#!/usr/bin/env bash
# scripts/loop.sh — busca a próxima issue e manda o Claude implementar
set -euo pipefail

REPO="${REPO:-seu-usuario/seu-repo}"
LABEL="ready-for-claude"
MAX_ATTEMPTS=3

# 1. Pega a próxima issue com a label correta
ISSUE=$(gh issue list \
  --repo "$REPO" \
  --label "$LABEL" \
  --state open \
  --limit 1 \
  --json number,title,body \
  --jq '.[0]')

if [ -z "$ISSUE" ] || [ "$ISSUE" = "null" ]; then
  echo "Nenhuma issue disponível. Bora tomar um café."
  exit 0
fi

NUMBER=$(echo "$ISSUE" | jq -r '.number')
TITLE=$(echo "$ISSUE"  | jq -r '.title')
BODY=$(echo "$ISSUE"   | jq -r '.body')

echo "Processando issue #$NUMBER: $TITLE"

# 2. Remove a label para não pegar de novo no próximo ciclo
gh issue edit "$NUMBER" --repo "$REPO" --remove-label "$LABEL"

# 3. Cria uma branch para o trabalho
BRANCH="claude/issue-$NUMBER"
git checkout -b "$BRANCH"

# 4. O verificador: arquivos protegidos, lint, tipos e testes
verificar() {
  # Arquivos protegidos são checados pelo diff, não pela permissão
  if git diff --name-only main | grep -qE 'src/stores/cart.ts|src/types/product.ts'; then
    echo "Arquivo protegido foi alterado: cart.ts ou product.ts"
    return 1
  fi
  pnpm lint && pnpm vue-tsc --noEmit && pnpm vitest run
}

# 5. Manda o Claude trabalhar
ATTEMPT=0
OUTPUT=""
while [ "$ATTEMPT" -lt "$MAX_ATTEMPTS" ]; do
  ATTEMPT=$((ATTEMPT + 1))
  echo "Tentativa $ATTEMPT/$MAX_ATTEMPTS"

  # Na primeira tentativa, manda implementar
  # Nas seguintes, manda corrigir com o erro como contexto
  if [ "$ATTEMPT" -eq 1 ]; then
    CONTINUE=""
    PROMPT="Issue #$NUMBER: $TITLE

$BODY

Implemente conforme o CLAUDE.md."
  else
    # --continue retoma a sessão anterior: o agente ainda lembra da issue
    CONTINUE="--continue"
    PROMPT="A implementação da issue #$NUMBER falhou na verificação.

Saída do verificador:
$(echo "$OUTPUT" | tail -n 50)

Analise os erros, identifique a causa e corrija.
Não refaça tudo: corrija apenas o que está falhando."
  fi

  claude $CONTINUE -p "$PROMPT" --allowedTools "Read,Write,Edit,Bash(pnpm:*)"

  # 6. Verifica (e guarda a saída para a próxima tentativa)
  if OUTPUT=$(verificar 2>&1); then
    echo "Verificação passou na tentativa $ATTEMPT."
    git add -A
    git commit -m "feat: issue #$NUMBER — $TITLE (tentativa $ATTEMPT)"
    git push origin "$BRANCH"
    gh pr create \
      --repo "$REPO" \
      --title "feat: issue #$NUMBER — $TITLE" \
      --body "Closes #$NUMBER" \
      --label "claude-pr"
    git checkout main
    exit 0
  fi

  echo "Tentativa $ATTEMPT falhou."
done

# 7. Esgotou as tentativas: avisa na issue com o último erro e limpa
echo "Falhou após $MAX_ATTEMPTS tentativas."
gh issue edit "$NUMBER" --repo "$REPO" --add-label "claude-failed"
gh issue comment "$NUMBER" --repo "$REPO" --body "Loop falhou após $MAX_ATTEMPTS tentativas. Revisar manualmente.

Último erro:
\`\`\`
$(echo "$OUTPUT" | tail -n 50)
\`\`\`"
git checkout main
git branch -D "$BRANCH"
exit 1

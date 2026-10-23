# Loop engineering · Vue starter

Projeto inicial do artigo "Loop engineering: o dev não escreve mais o prompt, projeta o sistema que escreve".

Um catálogo mínimo em Vue 3 + TypeScript + Pinia + Vitest, com o harness do Claude Code e o loop já configurados. A primeira issue sugerida é a wishlist descrita no artigo.

## Pré-requisitos
- Node 22 e pnpm 9
- `gh` autenticado e `jq`
- Claude Code autenticado

## Começando
```bash
pnpm install
pnpm lint && pnpm typecheck && pnpm test
```

## Rodando o loop
1. Abra uma issue com o template "Tarefa para o loop".
2. Adicione a label `ready-for-claude`.
3. Rode `REPO=seu-usuario/seu-repo ./scripts/loop.sh`, ou deixe o GitHub Actions disparar sozinho (configure o secret `ANTHROPIC_API_KEY`).

## O que tem aqui
- `CLAUDE.md`: contexto e convenções para o agente
- `.claude/settings.json`: permissões e hooks
- `scripts/loop.sh`: o loop
- `.github/workflows/claude-loop.yml`: dispara o loop pela label
- `.github/ISSUE_TEMPLATE/ready-for-claude.md`: modelo de issue verificável

---
name: Tarefa para o loop
about: Issue que o loop.sh consegue implementar sozinho
labels: ''
---

<!-- Adicione a label ready-for-claude só quando a issue estiver completa. -->

## Contexto
<!-- Onde isso fica no sistema? Quais arquivos já existem e importam? -->

## Tarefa
<!-- O que exatamente deve ser criado ou alterado? Seja específico. -->
1.

## Restrições
<!-- O que não pode ser tocado? Que padrões seguir? -->
- Seguir o CLAUDE.md.
- Não modificar src/stores/cart.ts nem src/types/product.ts.

## Critério de aceitação
<!-- Precisa ser verificável por comando. "Ficar bom" não serve. -->
- Testes em `*.spec.ts` cobrindo: ...
- `pnpm lint`, `pnpm typecheck` e `pnpm test` passam.

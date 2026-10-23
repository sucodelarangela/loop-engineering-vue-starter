# CLAUDE.md

## Projeto
Loja de exemplo em Vue 3 usada para demonstrar loop engineering.
Issues com a label `ready-for-claude` são implementadas automaticamente por `scripts/loop.sh`.

## Stack
- Vue 3 com Composition API e `<script setup lang="ts">`
- TypeScript estrito (`strict` + `noUncheckedIndexedAccess`)
- Pinia com setup stores (`defineStore('nome', () => { ... })`)
- Vitest + @vue/test-utils, ambiente jsdom
- pnpm (nunca use npm ou yarn)

## Comandos
- `pnpm lint`: ESLint
- `pnpm typecheck`: vue-tsc
- `pnpm test`: Vitest em modo run
- Uma tarefa só está pronta quando os três passam.

## Estrutura
- `src/stores/`: stores Pinia, uma por arquivo, com `*.spec.ts` ao lado
- `src/components/`: componentes `.vue`, com `*.spec.ts` ao lado
- `src/types/`: tipos compartilhados
- `src/data/`: dados de exemplo

## Convenções
- Nomes de código em inglês; comentários e textos de interface em português.
- Siga o padrão de `src/stores/cart.ts` para novas stores. Nada de Options API.
- Nenhum `any`, nenhum `@ts-ignore`.
- Não adicione dependências sem que a issue peça.
- Acesso a `localStorage` sempre com try/catch (o código pode rodar em SSR).
- Escreva arquivos com as ferramentas Edit e Write, não com scripts Python ou Node.

## Arquivos protegidos
Não altere: `src/stores/cart.ts`, `src/types/product.ts`.
O loop rejeita qualquer mudança neles.

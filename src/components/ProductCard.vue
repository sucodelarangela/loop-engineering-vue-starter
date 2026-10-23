<script setup lang="ts">
import type { Product } from '@/types/product'
import { useCartStore } from '@/stores/cart'

defineProps<{ product: Product }>()

const cart = useCartStore()

const formatPrice = (value: number): string =>
  value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
</script>

<template>
  <article class="product-card">
    <h2>{{ product.name }}</h2>
    <p>{{ formatPrice(product.price) }}</p>
    <!-- O FavoriteButton da issue da wishlist entra aqui -->
    <button
      type="button"
      @click="cart.addItem(product)"
    >
      Adicionar ao carrinho
    </button>
  </article>
</template>

<style scoped>
.product-card {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 1rem;
}
</style>

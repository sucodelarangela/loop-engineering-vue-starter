<script setup lang="ts">
import ProductCard from '@/components/ProductCard.vue'
import { products } from '@/data/products'
import { useCartStore } from '@/stores/cart'

const cart = useCartStore()
</script>

<template>
  <main>
    <h1>Produtos</h1>
    <p>Itens no carrinho: {{ cart.count }}</p>
    <section class="product-grid">
      <ProductCard
        v-for="product in products"
        :key="product.id"
        :product="product"
      />
    </section>
  </main>
</template>

<style scoped>
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 1rem;
}
</style>

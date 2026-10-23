// Store de referência do projeto. Arquivo protegido: o loop não deve alterá-lo.
// Novas stores devem seguir este padrão (setup store, Composition API).
import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import type { Product } from '@/types/product'

export const useCartStore = defineStore('cart', () => {
  const items = ref<Product[]>([])

  const total = computed(() => items.value.reduce((sum, item) => sum + item.price, 0))
  const count = computed(() => items.value.length)

  function addItem(product: Product): void {
    items.value.push(product)
  }

  function removeItem(productId: number): void {
    items.value = items.value.filter((item) => item.id !== productId)
  }

  return { items, total, count, addItem, removeItem }
})

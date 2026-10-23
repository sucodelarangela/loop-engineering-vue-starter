import { describe, expect, it } from 'vitest'
import { mount } from '@vue/test-utils'
import { createPinia, setActivePinia } from 'pinia'
import ProductCard from './ProductCard.vue'
import { useCartStore } from '@/stores/cart'
import { products } from '@/data/products'

describe('ProductCard', () => {
  it('adiciona o produto ao carrinho ao clicar no botão', async () => {
    setActivePinia(createPinia())
    const product = products[0]!
    const wrapper = mount(ProductCard, { props: { product } })

    await wrapper.get('button').trigger('click')

    expect(useCartStore().count).toBe(1)
  })
})

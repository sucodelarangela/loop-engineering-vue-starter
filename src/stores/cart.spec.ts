// Teste de referência: novas stores devem ter testes neste formato.
import { beforeEach, describe, expect, it } from 'vitest'
import { createPinia, setActivePinia } from 'pinia'
import { useCartStore } from './cart'
import { products } from '@/data/products'

const smartphone = products[0]!
const sofa = products[1]!

describe('useCartStore', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
  })

  it('adiciona itens e atualiza o total', () => {
    const cart = useCartStore()
    cart.addItem(smartphone)
    cart.addItem(sofa)

    expect(cart.count).toBe(2)
    expect(cart.total).toBeCloseTo(2499.49)
  })

  it('remove itens pelo id', () => {
    const cart = useCartStore()
    cart.addItem(smartphone)
    cart.removeItem(smartphone.id)

    expect(cart.count).toBe(0)
  })
})

// Tipo compartilhado do catálogo. Arquivo protegido: o loop não deve alterá-lo.
export interface Product {
  id: number
  name: string
  category: string
  price: number
}

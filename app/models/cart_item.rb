class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  def subtotal
    item.price_add_tax * amount
  end
end

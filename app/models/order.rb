class Order < ApplicationRecord
  
  belongs_to :customer
  
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  
  validates :customer_id, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: 'は半角数字7桁で入力して下さい'}
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true, numericality: true
  validates :total_payment, presence: true, numericality: true
  validates :payment_method, presence: true
  validates :status, presence: true
  
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  
  def shipping_cost
    800
  end
end

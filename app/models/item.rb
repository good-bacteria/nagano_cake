class Item < ApplicationRecord
  belongs_to :genre
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :cart_items, dependent: :destroy
  
  has_one_attached :image
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
  def price_add_tax
      tax = 1 + 0.10
      ( self.price * tax).floor
  end
end

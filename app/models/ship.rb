class Ship < ApplicationRecord
  
  belongs_to :customer
  
  validates :postal_code,presence:true ,format: { with: /\A\d{7}\z/ }
  validates :address,presence:true
  validates :name,presence:true
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end

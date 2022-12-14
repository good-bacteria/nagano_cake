class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :ships, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  validates :last_name,presence:true
  validates :first_name,presence:true
  validates :last_name_kana,presence:true ,format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい'}
  validates :first_name_kana,presence:true ,format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい'}
  validates :postal_code,presence:true ,format: { with: /\A\d{7}\z/ }
  validates :address,presence:true
  validates :phone_number,presence:true ,format: { with: /\A\d{10,11}\z/ }
  validates :email,presence:true ,uniqueness: true
  
  def full_name
    self.last_name + " " + self.first_name
  end
  
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
end

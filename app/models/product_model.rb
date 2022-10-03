class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :product_models, through: :order_items
  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, length: { maximum: 20 }, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

end

class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, length: { maximum: 20 }, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

end

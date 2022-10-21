class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :description, :cep, presence: true
  validates :code, uniqueness: true
  validates_with ZipcodeValidator, fields: [:cep]   

  has_many :stock_products
  
  def full_description
    "#{code} - #{name}" 
  end
end

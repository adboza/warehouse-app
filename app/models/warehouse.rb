class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :description, :cep, presence: true
  validates :code, uniqueness: true
  #validates :cep, length: { in: 8..9 }
  validates_with ZipcodeValidator, fields: [:cep]   
  
  def full_description
    "#{code} - #{name}"
  end
end

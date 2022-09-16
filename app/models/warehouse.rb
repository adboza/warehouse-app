class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :description, :cep, presence: true
end

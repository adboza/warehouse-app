require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: '', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'sku is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 70, height:45, depth: 10, sku: '', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
  end
end

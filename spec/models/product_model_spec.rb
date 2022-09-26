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

    it 'weight is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: '' , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'weight must be greater than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 0 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'width is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: '', height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'width must be greater than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 0, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'height is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height: '', depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'height must be greater than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height:0, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'depth is mandatory' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height: 100, depth: '', sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'depth must be greater than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height: 100, depth: 0, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'sku must have less than 20 chars' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090-MuitoLongo', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'sku must be unique' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

      first_pm = ProductModel.create!(name: 'TV 50', weight: 8000 , width: 120, height:75, depth: 15, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end

    it 'supplier is mandatory' do
      #Arrange
      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 10, height: 100, depth: '15', sku: 'TV32-SAMSU-XPT090', supplier: nil)
      #Act 
      result = pm.valid?
      #Assert
      expect(result).to eq false
    end
  
  end
end

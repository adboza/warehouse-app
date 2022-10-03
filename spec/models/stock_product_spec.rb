require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')     
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
      supplier = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      order = Order.create!(user: user, warehouse: warehouse, status: :delivered, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      product = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      
      #Assert
      expect(stock_product.serial_number.length).to eq 20
    end  
    it 'e não é modificado' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
      other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', city: 'São Paulo', area: 200_000, address: 'Av Aeroporto, 10', description: 'Galpão internacional', cep: '01000-000')
      supplier = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      order = Order.create!(user: user, warehouse: warehouse,  status: :delivered, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      product = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number
      #Act
      stock_product.update!(warehouse: other_warehouse)
      #Assert      
      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end

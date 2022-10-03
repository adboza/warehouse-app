require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?'do
    it 'deve ter um código' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      login_as(user)
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
      supplier = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      #Act
      result = order.valid?
      #Assert
      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do      
      #Arrange
      order = Order.new(estimated_delivery_date: '')
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data estimada de entrega não deve ser passada' do      
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega não deve ser igual a hoje' do      
      #Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega deve ser igual ou maior que amanhã' do      
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be false
      
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      login_as(user)
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
      supplier = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      #Act
      order.save!
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end
    it 'e o código é único' do
      #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      login_as(user)
      warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
      supplier = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 42.days.from_now)
      #Act

      second_order.save!
      
      #Assert
      expect(second_order.code).not_to eq first_order.code
      
    end
  end
end

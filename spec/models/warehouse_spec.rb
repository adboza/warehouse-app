require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(name: '', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: '', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when city is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: '', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when area is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: '', address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when address is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: '', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when zipcode is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when description is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when zipcode length is not between 8 and 9 chars' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'123456', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when zipcode has irregular chars' do
        #Arrange
        warehouse = Warehouse.new(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'1234546a', description:'Galpão destinado para cargas internacionais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end
    end

    it 'false when code is already in use' do
      #Arrange
      first_warehouse = Warehouse.create(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')

      second_warehouse = Warehouse.new(name: 'Guarda do Embaú', code: 'GRU', city: 'Guarda do Embaú', area: 10_000, address: 'Beira do rio, 1000', cep:'85000-000', description:'Galpão destinado para cargas pesqueiras')

      # Act
      result = second_warehouse.valid?

      #Assert
      expect(result).to eq false
    end
  end

end

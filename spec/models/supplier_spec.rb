require 'rails_helper'

  
RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate name is empty' do
        #Arrange
        supplier = Supplier.new(
          corporate_name: '', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
        #Act
        result = supplier.valid?
        #Assert
        expect(result).to eq false
      end
      
      it 'false when registration number is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
        #Act
        result = supplier.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when brand name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'BOZA LTDA', brand_name: '', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
        #Act
        result = supplier.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when email is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: '', state: 'PR', phone_number: '554132771841')
        #Act
        result = supplier.valid?
        #Assert
        expect(result).to eq false
      end
      
      it 'false when registration number is not 14' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '123456789012345', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
        #Act
        result = supplier.valid?
        #Assert
        expect(result).to eq false
      end
    end

    it 'false when registration number is already in use' do
      #Arrange
      supplier_one = Supplier.create(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')

      supplier_two = Supplier.new(corporate_name: 'Carloto LTDA', brand_name: 'Carloto', registration_number: '43447223000102', city: 'Campo Largo', full_address: 'Av. da Indústria, 1000', email: 'vendas@carloto.com.br', state: 'PR', phone_number: '554132321877')

      # Act
      result = supplier_two.valid?

      #Assert
      expect(result).to eq false
    end
  end
end

require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    #Arrange
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447216000102', city: 'Bauru', full_address: 'Torre da Indústria, 1', email: 'vendas@spark.com.br', state: 'SP')
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(current_path).to eq(suppliers_path)
  end
end

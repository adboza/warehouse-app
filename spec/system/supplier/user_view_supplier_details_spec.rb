require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      #Act
      visit root_path
      click_on 'Fornecedores'
      click_on 'BOZA'
      #Assert
      expect(page).to have_content('BOZA LTDA')
      expect(page).to have_content('Documento: 43447223000102')
      expect(page).to have_content('Endereço: Torre da Indústria, 1')
      expect(page).to have_content('E-mail: vendas@boza.com.br')    
  end

  it 'e volta para a tela inicial' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'BOZA'
    click_on 'Voltar'
    #Assert
    expect(current_path).to eq root_path
  end
end

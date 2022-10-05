require 'rails_helper'

describe 'Usuário vê  fornecedores' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(current_path).to eq suppliers_path
  end
  it 'e visualiza lista de fornecedores' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
      Supplier.create!(
        corporate_name: 'Carloto LTDA', brand_name: 'Carloto', registration_number: '43447213000102', city: 'Campo Largo', full_address: 'Torre da Indústria, 1', email: 'vendas@carloto.com.br', state: 'PR', phone_number: '554132321877')
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('BOZA')
    expect(page).to have_content('Curitiba - PR')
    expect(page).to have_content('Carloto')
    expect(page).to have_content('Campo Largo - PR')
  end
  it 'e não existem fornecedores cadastrados' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end

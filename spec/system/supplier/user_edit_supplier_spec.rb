require 'rails_helper'

describe 'Usuário edita um Fornecedor' do
  it 'a partir da página de detalhes do fornecedor' do
    #Arrange
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR')
 
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'BOZA'
    click_on 'Editar'
    #Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
  end

  it 'com sucesso' do
    #Arrange
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'BOZA'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Boza Soluções'
    fill_in 'Endereço', with: 'Av dos Girassois,10'    
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Boza Soluções')
    expect(page).to have_content('Av dos Girassois,10')
       
  end

  it 'com preenchimento incorreto' do
    #Arrange
    Supplier.create!(
      corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'BOZA'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Não foi possível atualizar o fornecedor')
  end
end
require 'rails_helper'

describe 'registrar modelo de produto' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
    other_supplier = Supplier.create!(corporate_name: 'LG Brasil LTDA', brand_name: 'LG', registration_number: '45447223000102', city: 'São Paulo', full_address: 'Av da Indústria, 1', email: 'vendas@boza.com.br', state: 'SP', phone_number: '554132771841')

    ProductModel.create!(name: 'TV 32', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT000', supplier: supplier)
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: 8_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV32-SAMSU-XPT090'
    select 'LG', from: 'Fornecedor'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPT090'
    expect(page).to have_content 'Fornecedor: LG'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'deve preencher todos os campos' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
  end
end
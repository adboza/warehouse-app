require 'rails_helper'
include Warden::Test::Helpers

describe 'Usuario ve modelos de produtos' do

  it 'se estiver autenticado' do
    #Arrange
      #nada
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq new_user_session_path

  end
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #Act
    
    visit root_path    
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    #Assert
    expect(current_path).to eq product_models_path

  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'vendas@boza.com.br', state: 'PR', phone_number: '554132771841')

    ProductModel.create!(name: 'TV 32', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000 , width: 80, height:45, depth: 20, sku: 'SOUND-SAMSU-XPT090', supplier: supplier)

    #Act
    visit root_path
    
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Modelos de Produtos'
    #Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPT090'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOUND-SAMSU-XPT090'
  end

  it 'e não existem produtos cadastrados' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    #Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end

end
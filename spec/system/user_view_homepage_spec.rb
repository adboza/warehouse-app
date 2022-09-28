require 'rails_helper'

describe 'Usuario visita tela inicial' do
 
  it 'e vê o nome da app' do
    # Arrange

    #Act
    visit(root_path)    

    #Assert
    expect(page).to have_content('Galpões & Estoque')
    #expect(page).to have_
  end

  it 'e vê galpões cadastrados' do
    #arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #cadastrar 2 galpões
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av XV de Novembro, 15', description: 'Galpão fluminense', cep: '21000-000')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano', cep: '91000-000')

    #act
    visit(root_path)
    #assert
    #garantir que eu vejo na tela os galpões 
    expect(page).not_to have_content('Não existem galpões cadastrados!')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
    
  end

  it 'e não existem galpões cadastrados' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #Act
    visit(root_path)
    #Assert
    expect(page).to have_content('Não existem galpões cadastrados!')
  end
  it 'e vê menu com link para fornecedores' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    visit(root_path)
    #Act
    within('nav') do
      click_on 'Fornecedores'
    end
    #Assert
    expect(current_path).to eq suppliers_path
  end

  
end
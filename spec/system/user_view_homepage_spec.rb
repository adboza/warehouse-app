require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange

    #Act
    visit(root_path)    

    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê galpões cadastrados' do
    #arrange
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
    #Act
    visit(root_path)
    #Assert
    expect(page).to have_content('Não existem galpões cadastrados!')
  end

  
end
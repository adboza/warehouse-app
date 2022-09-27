require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
    #Act
    visit root_path
    click_on 'Maceio'
    click_on 'Remover'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).not_to have_content 'Maceio'
    expect(page).not_to have_content 'MCZ'
  end
  it 'e não apaga outros galpões' do
    #arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    login_as(user)
    #cadastrar 2 galpões
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av XV de Novembro, 15', description: 'Galpão fluminense', cep: '21000-000')
    second_warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano', cep: '91000-000')

    #act
    visit(root_path)
    click_on 'Maceio'
    click_on 'Remover'
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).to have_content 'SDU'
    expect(page).not_to have_content 'Maceio'
    expect(page).not_to have_content 'MCZ'
    
  end
end
require 'rails_helper'

describe 'Usuário edita um Galpão' do
  it 'a partir da página de detalhes' do
    #Arrange
     Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano', cep: '91000-000')
 
    #Act
    visit root_path
    click_on 'Maceio'
    click_on 'Editar'
    #Assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end

  it 'com sucesso' do
    #Arrange
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
    #Act
    visit root_path
    click_on 'Maceio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão Maceio'
    fill_in 'Endereço', with: 'Av dos Galpões,10'
    fill_in 'Descrição', with: 'Galpão alagoano de logística'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Nome: Galpão Maceio')
    expect(page).to have_content('Galpão alagoano de logística')
       
  end

  it 'com preenchimento incorreto' do
    #Arrange
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
    #Act
    visit root_path
    click_on 'Maceio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Não foi possível atualizar o galpão')
  end
end

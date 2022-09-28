require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Registrar Pedido'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    login_as(user)
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '43447223000102', city: 'Teresina', full_address: 'Torre da Industria, 1', email: 'vendas@spark.com.br', state: 'PI', phone_number: '558132771841')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    allow(SecureRandom).to receive(:alphanumeric).and_return('AB12345678')
    #Act
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.full_description, from: 'Fornecedor' 
    fill_in 'Data Prevista', with: '20/12/2022'
    click_on 'Gravar'
    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Código do Pedido: AB12345678'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA - CNPJ: 43447226000102'
    expect(page).to have_content 'Usuário Responsável: Sergio - sergio@email.com'
    expect(page).not_to have_content 'Maceio'
    expect(page).not_to have_content 'Spark'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
  end
end
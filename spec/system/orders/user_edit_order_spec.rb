require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
     #Arrange
     joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
     warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
     supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
     order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
          
     #Act     
     visit edit_order_path(order.id)

     #Assert
     expect(current_path).to eq new_user_session_path
  end
  
  it 'com sucesso' do
    #Arrange
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    second_supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '55447226000102', city: 'São Paulo', full_address: 'Av Vargas, 100', email: 'contato@spark.com', state: 'SP', phone_number: '551132771855')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         
    #Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select second_supplier.full_description, from: 'Fornecedor' 
    fill_in 'Data Prevista de Entrega', with: 2.days.from_now
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso'    
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Spark - Spark Industries Brasil LTDA - CNPJ: 55447226000102'
    formated_date = I18n.localize(2.days.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formated_date}"
  end

  it 'caso seja o responsável' do
    #Arrange
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: '12345678')
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         
    #Act
    login_as(andre) 
    visit edit_order_path(order.id)

    #Assert
    expect(current_path).to eq root_path
 end
end
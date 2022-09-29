require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    login_as(user)
    #Act
    visit root_path
    #Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'e deve estar autenticado' do
    #Arrange
    
    #Act
    visit root_path
    #Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end
  it 'e encontra um pedido' do
    #Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    #Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código do Pedido: #{order.code}"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME - ACME LTDA'
    
  end

  it 'e encontra múltiplos pedidos' do
    #Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')    
      first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
      second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 50_000, address: 'Avenida XV de Novembro, 1', cep:'21000-000', description:'Galpão carioca')
          
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
  
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU2345678')
      first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU2345999')
      second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 5.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU2345678')
      third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
      
      #Act
      login_as(user)
      visit root_path
      fill_in 'Buscar Pedido', with: "GRU"
      click_on 'Buscar'
      #Assert
      expect(page).to have_content "2 pedidos encontrados"
      expect(page).to have_content 'GRU2345678'
      expect(page).to have_content 'GRU2345999'
      expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
      expect(page).not_to have_content 'SDU2345678'
      expect(page).not_to have_content 'Galpão Destino: SDU - Aeroporto Rio'
  end
end
require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    #Arrange
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status:'pending')
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'delivered')
    third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'canceled')
    
    #Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content 'Cancelado'
  end

  it 'e vê detalhes de um pedido' do
    #Arrange
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    #Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code
    #Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME'
    formated_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formated_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    #Arrange
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: '12345678')
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(user: andre, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    #Act
    login_as(andre)
    visit order_path(first_order.id)
    
    #Assert
    expect(current_path).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end
  it 'e vê itens do pedido' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    product_a = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 3000 , width: 80, height:45, depth: 20, sku: 'SOUND-SAMSU-XPT090', supplier: supplier)
    product_c = ProductModel.create!(name: 'Produto C', weight: 1000 , width: 30, height:15, depth: 20, sku: 'SOUND-SAMSU-TPT090', supplier: supplier)
    
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    #Assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'
    expect(page).not_to have_content 'Produto C'
  end
end
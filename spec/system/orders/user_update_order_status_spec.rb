require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    #Arrange
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    product = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)    

    OrderItem.create!(order: order, product_model: product, quantity:5)

    #Act
    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code    
    click_on 'Marcar como ENTREGUE'
    
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido'
    expect(page).not_to have_content 'Marcar como CANCELADO'
    expect(page).not_to have_content 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(estoque).to eq 5
  end

  it 'e pedido foi cancelado' do
    #Arrange
    joao = User.create!(name: 'Joao', email: 'joao@bmail.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000202', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    product = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)    

    OrderItem.create!(order: order, product_model: product, quantity:5)
    #Act
    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido'
    expect(StockProduct.count).to eq 0
  end
end
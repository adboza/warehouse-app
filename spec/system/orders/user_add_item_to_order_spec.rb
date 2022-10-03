require 'rails_helper'

describe 'Usuário adiciona itens a pedido já existente' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 3000 , width: 80, height:45, depth: 20, sku: 'SOUND-SAMSU-XPT090', supplier: supplier)
    
    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
    
  end
  it 'e não vê produtos de outro fornecedor' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '12345678') 
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
    supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447226000102', city: 'Bauru', full_address: 'Av das Palmas, 100', email: 'contato@acme.com', state: 'SP', phone_number: '551132771841')
    supplier_b = Supplier.create!(corporate_name: 'BOZA LTDA', brand_name: 'BOZA', registration_number: '77447226000102', city: 'Curitiba', full_address: 'Av das Araucarias, 100', email: 'contato@boza.com', state: 'PR', phone_number: '554132771841')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier_a)
    product_b = ProductModel.create!(name: 'Produto B', weight: 3000 , width: 80, height:45, depth: 20, sku: 'SOUND-SAMSU-XPT090', supplier: supplier_b)
    
    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    
    #Assert    
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
    
  end
end
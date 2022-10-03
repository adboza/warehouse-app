require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
    login_as(user)
    w = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Deodoro, 10', description: 'Galpão alagoano de logística', cep: '91000-000')
    other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', city: 'São Paulo', area: 200_000, address: 'Av Aeroporto, 10', description: 'Galpão internacional', cep: '01000-000')
    supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '43447223000102', city: 'Curitiba', full_address: 'Torre da Indústria, 1', email: 'sac@samsung.com.br', state: 'PR', phone_number: '554132771841')
    order = Order.create!(user: user, warehouse: w,  supplier: supplier, estimated_delivery_date: 2.days.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000 , width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    product_soundbar = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 8000 , width: 70, height:45, depth: 10, sku: 'SOUND-SAMSU-XPT090', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 8000 , width: 70, height:45, depth: 10, sku: 'NOTE-SAMSU-XPT090', supplier: supplier)
    
    3.times { StockProduct.create!(order: order, warehouse: w, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: w, product_model: product_notebook) }
    #Act
    visit root_path
    click_on 'Maceio'
    #Assert
    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV32-SAMSU-XPT090'
    expect(page).to have_content '2 x NOTE-SAMSU-XPT090'
    expect(page).not_to have_content 'SOUND-SAMSU-XPT090'
    


  end
end
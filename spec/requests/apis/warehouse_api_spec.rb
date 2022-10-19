require 'rails_helper'
describe 'Warehouse API' do
  context 'GET /app/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep:'15000-000', description:'Galpão destinado para cargas internacionais')
      # id = warehouse.id.to_i
      # puts id

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response ["name"]).to eq('Aeroporto SP')
      expect(json_response ["code"]).to eq('GRU')

    end
  end
end
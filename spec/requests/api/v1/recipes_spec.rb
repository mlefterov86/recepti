require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  describe 'GET /index' do
    let!(:recipe1) { FactoryBot.create(:recipe) }
    let!(:recipe2) { FactoryBot.create(:recipe) }
    let(:response_body) do
      [
        {
          'id' => recipe2.id,
          'name' => recipe2.name,
          'ingredients' => recipe2.ingredients.map { |r| { 'id' => r.id, 'name' => r.name } }
        },
        {
          'id' => recipe1.id,
          'name' => recipe1.name,
          'ingredients' => recipe1.ingredients.map { |r| { 'id' => r.id, 'name' => r.name } }
        }
      ]
    end

    context 'when no query param provided' do
      it 'returns http success' do
        get '/api/v1/recipes'
        body = JSON.parse(response.body)
        expect(body).to eq response_body
        expect(response).to have_http_status(:success)
      end
    end

    context 'when query params provided' do
      let(:query_params) { [{ 'id' => recipe1.ingredients.first.id }] }

      it 'returns http success' do
        get '/api/v1/recipes', params: { ingredient_ids: query_params.to_json }
        body = JSON.parse(response.body)
        expect(body).to eq [{
                               'id' => recipe1.id,
                              'name' => recipe1.name,
                              'ingredients' => recipe1.ingredients.map { |r| { 'id' => r.id, 'name' => r.name } }
                            }]
        expect(response).to have_http_status(:success)
      end
    end
  end
end

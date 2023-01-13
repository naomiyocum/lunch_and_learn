require 'rails_helper'

RSpec.describe EdamamService do
  describe 'class methods' do
    describe '.conn' do
      it 'connects to the Edamam API' do
        conn = EdamamService.conn
        expect(conn.params).to have_key :app_id
        expect(conn.params).to have_key :app_key
        expect(conn.params).to have_key :type
      end
    end

    describe '.get_url' do
      it 'parses through the response body and returns a JSON hash with keys as symbols' do
        url = EdamamService.get_url("/api/recipes/v2?q=Japan")
        expect(url).to be_a Hash
      end
    end

    describe '.get_recipes' do
      it 'returns recipes from a specific country' do
        recipes = EdamamService.get_recipes('Japan')
        expect(recipes).to be_a Hash
        expect(recipes[:hits]).to be_an Array
        
        recipe = recipes[:hits][0][:recipe]
        expect(recipe).to have_key :uri
        expect(recipe).to have_key :label
        expect(recipe).to have_key :image
      end
    end
  end
end
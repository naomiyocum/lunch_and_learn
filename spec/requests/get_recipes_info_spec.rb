require 'rails_helper'

RSpec.describe 'Get Recipes Info' do
  it 'returns recipes info based on a country' do
    country = 'Japan'
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    get "/api/v1/recipes?country=#{country}", headers: headers

    expect(response).to be_successful
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)

    first_recipe = parsed_response[:data][0]
    expect(first_recipe).to have_key(:id)
    expect(first_recipe).to have_key(:type)
    expect(first_recipe).to have_key(:attributes)
    expect(first_recipe[:attributes]).to have_key(:title)
    expect(first_recipe[:attributes]).to have_key(:url)
    expect(first_recipe[:attributes]).to have_key(:country)
    expect(first_recipe[:attributes]).to have_key(:image)
  end
end 
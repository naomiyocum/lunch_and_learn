require 'rails_helper'

RSpec.describe 'Get Recipes Info' do
  it 'returns recipes info based on a country' do
    VCR.use_cassette 'get recipes info' do
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

  it 'checks recipes for a random country if no country is provided' do
    json = File.read('spec/fixtures/random_country.json')

    stub_request(:get, 'https://restcountries.com/v3.1/all')
      .with(query: hash_including({}))
      .to_return(status: 200, body: json)
    
    VCR.use_cassette 'Grenada' do
      headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
      get "/api/v1/recipes", headers: headers

      expect(response).to be_successful
      
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to be_a Hash
      expect(parsed_response).to have_key(:data)
    end
  end

  it 'returns an error if country is invalid' do
    VCR.use_cassette 'pizza country' do
      country = 'Pizza'
      headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
      get "/api/v1/recipes?country=#{country}", headers: headers
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(parsed_response[:errors][0][:status]).to eq('INVALID COUNTRY')
      expect(parsed_response[:errors][0][:message]).to eq('This is not a country, please try again')
    end
  end
end 
require 'rails_helper'

RSpec.describe 'Post Favorites' do
  before do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Monkey Luffy', 'email': 'pirateking@onepiece.jp' }
    post '/api/v1/users', headers: headers, params: body, as: :json
    @user = User.last
  end

  it 'adds recipes to a favorited list of a particular user' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    post '/api/v1/favorites', headers: headers, params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key :success
    expect(parsed_response[:success]).to eq('Favorite added successfully')
  end

  xit 'sends an error message with appropriate response if the api_key is invalid' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'api_key': "igotthekeys", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    post '/api/v1/favorites', headers: headers, params: body, as: :json

    expect(response.status).to eq(400)
  end
end
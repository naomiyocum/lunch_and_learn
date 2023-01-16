require 'rails_helper'

RSpec.describe 'Delete a Favorite' do
  before do
    @headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Monkey Luffy', 'email': 'pirateking@onepiece.jp' }
    post '/api/v1/users', headers: headers, params: body, as: :json
    @user = User.last

    body_2 = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    body_3 = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/homemade-miso-soup/', 'recipe_title': 'Miso Soup'}
    post '/api/v1/favorites', headers: @headers, params: body_2, as: :json
    post '/api/v1/favorites', headers: @headers, params: body_3, as: :json
  end

  it 'deletes a favorite from the database' do
    expect(Favorite.count).to eq(2)
    params = { 'api_key': "#{@user.api_key}", 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/'}
    delete '/api/v1/favorites', headers: @headers, params: params, as: :json
    
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Favorite.count).to eq(1)
  end

  it 'returns an error message if no favorite is found' do
    params = { 'api_key': "igotthekeys", 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/'}
    delete '/api/v1/favorites', headers: @headers, params: params, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:status]).to eq('PLEASE TRY AGAIN')
    expect(parsed_response[:errors][0][:message]).to eq('Favorite does not exist')
  end
end
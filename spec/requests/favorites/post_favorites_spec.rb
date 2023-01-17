require 'rails_helper'

RSpec.describe 'Post Favorites' do
  before do
    @headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 
              'name': 'Monkey Luffy',
              'email': 'pirateking@onepiece.jp',
              'password': 'gostrawhats',
              'password_confirmation': 'gostrawhats'
            }
    post '/api/v1/users', headers: headers, params: body, as: :json
    @user = User.last
  end

  it 'adds recipes to a favorited list of a particular user' do
    body = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    post '/api/v1/favorites', headers: @headers, params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key :success
    expect(parsed_response[:success]).to eq('Favorite added successfully')
  end

  it 'sends an error message with appropriate response if the api_key is invalid' do
    body = { 'api_key': "igotthekeys", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    post '/api/v1/favorites', headers: @headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:status]).to eq('PLEASE TRY AGAIN')
    expect(parsed_response[:errors][0][:message]).to eq('User does not exist')
  end

  it 'sends an appropriate error message if the body is missing some params' do
    body = { 'api_key': "#{@user.api_key}", 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    post '/api/v1/favorites', headers: @headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:status]).to eq('PLEASE TRY AGAIN')
    expect(parsed_response[:errors][0][:message]).to eq('Make sure to include all necessary params')
  end
end
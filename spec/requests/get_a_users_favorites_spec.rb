require 'rails_helper'

RSpec.describe 'Get A User\'s Favorites' do
  before do
    @headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Monkey Luffy', 'email': 'pirateking@onepiece.jp' }
    post '/api/v1/users', headers: headers, params: body, as: :json
    @user = User.last
  end

  it 'gets all of the favorites for a paritcular user' do
    body_2 = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/okinawa-soba/', 'recipe_title': 'Okinawa Soba 沖縄そば'}
    body_3 = { 'api_key': "#{@user.api_key}", 'country': 'Japan', 'recipe_link': 'https://www.justonecookbook.com/homemade-miso-soup/', 'recipe_title': 'Miso Soup'}
    post '/api/v1/favorites', headers: @headers, params: body_2, as: :json
    post '/api/v1/favorites', headers: @headers, params: body_3, as: :json

    params = { 'api_key': "#{@user.api_key}" }
    get "/api/v1/favorites", headers: @headers, params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)

    first_fav = parsed_response[:data][0]
    expect(first_fav).to have_key(:id)
    expect(first_fav).to have_key(:type)
    expect(first_fav[:type]).to eq('favorite')
    expect(first_fav).to have_key(:attributes)
    expect(first_fav[:attributes]).to have_key(:recipe_title)
    expect(first_fav[:attributes][:recipe_title]).to eq('Okinawa Soba 沖縄そば')
    expect(first_fav[:attributes]).to have_key(:recipe_link)
    expect(first_fav[:attributes][:recipe_link]).to eq('https://www.justonecookbook.com/okinawa-soba/')
    expect(first_fav[:attributes]).to have_key(:country)
    expect(first_fav[:attributes][:country]).to eq('Japan')
    expect(first_fav[:attributes]).to have_key(:created_at)
  end

  it 'points to an empty data object if user has not favorited any recipes' do
    params = { 'api_key': "#{@user.api_key}" }
    get "/api/v1/favorites", headers: @headers, params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to eq([])
  end

  it 'sends an appropriate error message with appropriate response if the api_key is invalid' do
    params = { 'api_key': "keyskeyskeys" }
    get "/api/v1/favorites", headers: @headers, params: params

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:status]).to eq('PLEASE TRY AGAIN')
    expect(parsed_response[:errors][0][:message]).to eq('User does not exist')
  end

   it 'returns an appropriate error message if params are missing' do
    get "/api/v1/favorites", headers: @headers

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:status]).to eq('PLEASE TRY AGAIN')
    expect(parsed_response[:errors][0][:message]).to eq('Make sure to include all necessary params')
  end
end
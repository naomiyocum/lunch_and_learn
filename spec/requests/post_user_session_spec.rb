require 'rails_helper'

RSpec.describe 'Post User Session' do
  before do
    @headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Zuko Yocum',
             'email': 'firenationrules@avatar.com',
             'password': 'password123',
             'password_confirmation': 'password123' }
    post '/api/v1/users', headers: @headers, params: body, as: :json
  end

  it 'logs in the user' do
    body = { 'email': 'firenationrules@avatar.com', 'password': 'password123' }
    post '/api/v1/sessions', headers: @headers, params: body, as: :json

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key :data
    expect(parsed_response[:data]).to have_key :id
    expect(parsed_response[:data]).to have_key :type
    expect(parsed_response[:data]).to have_key :attributes
    expect(parsed_response[:data][:attributes]).to have_key :name
    expect(parsed_response[:data][:attributes][:name]).to eq('Zuko Yocum')
    expect(parsed_response[:data][:attributes]).to have_key :email
    expect(parsed_response[:data][:attributes][:email]).to eq('firenationrules@avatar.com')
    expect(parsed_response[:data][:attributes]).to have_key :api_key
  end

  it 'gives an appropriate error message when user does not exist' do
    body = { 'email': 'naomiyocum24@gmail.com', 'password': 'password123' }
    post '/api/v1/sessions', headers: @headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:message]).to eq('User does not exist')
  end

  it 'gives an appropriate error message when password does not match' do
    body = { 'email': 'firenationrules@avatar.com', 'password': 'ilovefire' }
    post '/api/v1/sessions', headers: @headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:message]).to eq('Incorrect password')
  end
end
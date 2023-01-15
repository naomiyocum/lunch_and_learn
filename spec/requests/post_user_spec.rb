require 'rails_helper'

RSpec.describe 'Post User' do
  it 'creates the user in the database with a random api key' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Zuko Yocum', 'email': 'firenationrules@avatar.com' }
    post '/api/v1/users', headers: headers, params: body, as: :json
    
    expect(response).to be_successful
    expect(response.status).to eq(201)
    
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

  it 'sends an error message with appropriate response when user creation has a duplicated email' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Zuko Yocum', 'email': 'firenationrules@avatar.com' }
    post '/api/v1/users', headers: headers, params: body, as: :json
    
    expect(response).to be_successful
    expect(response.status).to eq(201)

    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    body = { 'name': 'Naomi Yocum', 'email': 'firenationrules@avatar.com' }
    post '/api/v1/users', headers: headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:message]).to eq('Email has already been taken')
  end

  it 'sends an appropriate error message when user does not include name or email' do
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    post '/api/v1/users', headers: headers, params: body, as: :json

    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors][0][:message]).to eq('Name can\'t be blank and Email can\'t be blank')
  end
end
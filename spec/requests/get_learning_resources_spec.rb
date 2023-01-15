require 'rails_helper'

RSpec.describe 'Get Learning Resource for a Particular Country' do
  it 'returns learning resources info including photos and a youtube video based on country' do
    country = 'Japan'
    headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}
    get "/api/v1/learning_resources?country=#{country}", headers: headers

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to have_key(:id)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data]).to have_key(:attributes)
    attrs = parsed_response[:data][:attributes]
    expect(attrs).to have_key(:country)
    expect(attrs).to have_key(:video)
    expect(attrs[:video]).to have_key(:title)
    expect(attrs[:video]).to have_key(:youtube_video_id)
    expect(attrs).to have_key(:images)
    expect(attrs[:images][0]).to have_key(:alt_tag)
    expect(attrs[:images][0]).to have_key(:url)
  end
end
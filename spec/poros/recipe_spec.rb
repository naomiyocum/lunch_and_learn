require 'rails_helper'

RSpec.describe Recipe do
  it 'exists' do
    attrs = {
      :recipe => {
        label: 'Okinawa Soba',
        image: 'https://en.wikipedia.org/wiki/Okinawa_soba#/media/File:Soki_soba_in_Naha.jpg',
        url: 'https://www.justonecookbook.com/okinawa-soba/'
      }
    }
    country = 'Japan'

    soba = Recipe.new(attrs, country)

    expect(soba).to be_an_instance_of Recipe
    expect(soba.title).to eq('Okinawa Soba')
    expect(soba.image).to eq('https://en.wikipedia.org/wiki/Okinawa_soba#/media/File:Soki_soba_in_Naha.jpg')
    expect(soba.url).to eq('https://www.justonecookbook.com/okinawa-soba/')
  end
end
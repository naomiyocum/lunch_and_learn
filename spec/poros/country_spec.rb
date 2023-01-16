require 'rails_helper'

RSpec.describe Country do
  it 'exists' do
    attrs = {
      :name => {
        common: 'Japan'
      }
    }

    country = Country.new(attrs)

    expect(country).to be_an_instance_of Country
    expect(country.name).to eq('Japan')
  end

  describe 'class methods' do
    describe '.valid_country?' do
      it 'returns true/false depending if country is a valid country' do
        VCR.use_cassette 'validating countries' do
          expect(Country.valid_country?('Singapore')).to be true
          expect(Country.valid_country?('thailand')).to be true
          expect(Country.valid_country?('tamago')).to be false
          expect(Country.valid_country?('negi')).to be false
        end
      end
    end

    describe '.random_country' do
      it 'returns a random country each time' do
        VCR.use_cassette 'random_country' do
          country = Country.random_country
          expect(country).to be_a String
        end
      end
    end
  end
end
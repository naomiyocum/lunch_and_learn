require 'rails_helper'

RSpec.describe CountriesService do
  describe 'class methods' do
    describe '.conn' do
      it 'connects to the REST Countries API' do
        conn = CountriesService.conn
        expect(conn.headers).to have_value 'Faraday v2.7.5'
      end
    end

    describe '.get_all_countries' do
      it 'returns a collection of countries' do
        VCR.use_cassette 'service countries' do
          countries = CountriesService.get_all_countries
          expect(countries).to be_an Array
        end
      end
    end
  end
end
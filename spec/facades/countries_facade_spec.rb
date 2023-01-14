require 'rails_helper'

RSpec.describe CountriesFacade do
  describe 'class methods' do
    describe '.all_countries' do
      it 'returns a collection of countries' do
        countries = CountriesFacade.all_countries
        expect(countries[0]).to be_an_instance_of Country
      end
    end
  end
end
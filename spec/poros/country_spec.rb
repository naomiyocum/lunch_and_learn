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
end
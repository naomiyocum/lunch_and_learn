require 'rails_helper'

RSpec.describe Favorite do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:api_key) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:recipe_link) }
    it { is_expected.to validate_presence_of(:recipe_title) }
  end
end
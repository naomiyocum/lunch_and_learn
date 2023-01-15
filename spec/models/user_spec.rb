require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :favorites }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'instance methods' do
    describe '#generate_api_key' do
      it 'generates an api key for each user after creation' do
        user = create(:user)
        expect(user.api_key).to_not be_empty
      end
    end
  end
end
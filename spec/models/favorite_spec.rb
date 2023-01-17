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

  describe 'class methods' do
    describe '.find_my_favorites' do
      it 'returns favorites of a particular user' do
        @user = create(:user, password: 'password123', password_confirmation: 'password123')
        @user_2 = create(:user, password: 'password123', password_confirmation: 'password123')
        create_list(:favorite, 4, user: @user, api_key: @user.api_key)
        @favorite = create(:favorite, user: @user_2)
        
        faves = Favorite.find_my_favorites(@user.api_key)

        expect(faves.count).to eq(4)
        expect(faves.include?(@favorite)).to be false
      end
    end
  end
end
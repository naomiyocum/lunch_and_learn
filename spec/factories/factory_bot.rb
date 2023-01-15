FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::JapaneseMedia::OnePiece.character }
    email { Faker::Internet.email }
  end

  factory :favorite, class: 'Favorite' do
    recipe_title { Faker::JapaneseMedia::OnePiece.sea }
    recipe_link { Faker::JapaneseMedia::OnePiece.quote }
    api_key { Faker::JapaneseMedia::OnePiece.akuma_no_mi }
    country { Faker::JapaneseMedia::OnePiece.location }
    user
  end
end
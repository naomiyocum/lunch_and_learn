FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::JapaneseMedia::OnePiece.character }
    email { Faker::Internet.email }
  end
end
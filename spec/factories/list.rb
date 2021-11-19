FactoryBot.define do
  factory :post_image do
    post_name { Faker::Lorem.characters(number:10) }
    caption { Faker::Lorem.characters(number:30) }
  end
end
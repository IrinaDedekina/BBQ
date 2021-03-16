FactoryBot.define do
  factory :user do
    sequence(:name) {  |n| "user_№#{n}" }

    email { |n| "#{n}@example.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456" }
  end
end

FactoryBot.define do
  factory :event do
    association :user

    sequence(:title) { |n| "Событие #{n}" }
    description { |n| "Описание #{n}" }
    address { "Москва" }
    datetime { Time.parse("2021.04.20, 13:00") }
  end
end
FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "author name#{n}" }
  end
end

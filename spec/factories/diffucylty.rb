FactoryBot.define do
  factory :difficulty do
    sequence(:name) { |n| "difficulty_#{n}" }
  end
end

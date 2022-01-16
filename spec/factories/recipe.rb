FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "recipe#{n}" }
    prep_time { '10 min' }
    cook_time { '1 h'}
    total_time { '1h10' }
    rate { "4.8" }
    budget { "Coût moyen" }
    people_quantity { "4" }
    ingredients {
      [
        '1 ingredient',
        '2 ingredient',
        '3 ingredient',
      ]
    }

    diffculty
    author
  end
end
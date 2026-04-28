FactoryBot.define do
  factory :message do
    association :user
    body { Faker::Lorem.sentence(word_count: rand(5..15)) }

    trait :long_body do
      body { Faker::Lorem.paragraph_by_chars(number: 1001) }
    end

    trait :empty_body do
      body { "" }
    end

    trait :nil_body do
      body { nil }
    end
  end
end

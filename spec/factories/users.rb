FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "SecurePassword123!" }
    password_confirmation { "SecurePassword123!" }

    trait :with_messages do
      after(:create) { |user| create_list(:message, 3, user: user) }
    end
  end
end

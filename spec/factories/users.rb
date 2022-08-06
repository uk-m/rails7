FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { "Testuser" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end

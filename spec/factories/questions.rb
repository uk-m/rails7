FactoryBot.define do
  factory :question do
    title { "転職を考えている" }
    content { "testcontent" }
    category { "IT" }
    association :owner
    
    trait :invalid do
      name { nil }
    end
  end
end

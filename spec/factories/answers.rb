FactoryBot.define do
  factory :answer do
    content { "Testanswercontent" }
    association :question
    user { question.owner }
  end
end

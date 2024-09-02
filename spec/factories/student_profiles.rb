FactoryBot.define do
  factory :student_profile do
    user { nil }
    level_of_knowledge { "MyString" }
    interests { "MyText" }
  end
end

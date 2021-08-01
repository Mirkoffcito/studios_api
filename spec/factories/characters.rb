FactoryBot.define do
  factory :character do
    name { Faker::Name.name }
    age { rand(10..99) }
    weight { rand(37..105) }
    history { Faker::Lorem.paragraph(sentence_count:5) }
  end
end

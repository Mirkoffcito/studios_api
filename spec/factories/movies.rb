FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_date {"#{rand(1975..2021)}-#{rand(1..12)}-#{rand(1..28)}"}
    score { rand(1..5) }
    studio_id {}
  end
end

FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :admin_user do
      admin { true }
    end
  end
end
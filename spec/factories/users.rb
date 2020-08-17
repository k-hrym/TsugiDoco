FactoryBot.define do
  factory :user ,class: User do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {'password'}
  end
  factory :user_2 ,class: User do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {'password'}
  end
end

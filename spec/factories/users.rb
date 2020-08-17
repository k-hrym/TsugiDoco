FactoryBot.define do
  factory :user ,class: User do
    name {"test-user"}
    email {"user@test.com"}
    password {'password'}
  end
  factory :user_2 ,class: User do
    name {"test-user_2"}
    email {"user_2@test.com"}
    password {'password'}
  end
end

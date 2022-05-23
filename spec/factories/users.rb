FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # email { "#{name.gsub(/ /, "_")}@email.com" }
    random_email = Faker::Number.number(digits: 3).to_s + Faker::Internet.email
    email { random_email }
    password {'password'}
    password_confirmation { 'password'}
  end
end

require 'faker'


FactoryGirl.define do
  factory :user do
    name { Faker::Name.name}
    email {Faker::Internet.email}
    password "123456"
    password_confirmation "123456"
    description {Faker::Lorem.paragraph}
    phone {Faker::PhoneNumber}
    address {Faker::Address.street_name}
  end
end
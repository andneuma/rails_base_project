FactoryGirl.define do
  factory :user do
    name { Faker::Name.name.split(' ').join('_') }
    email { rand(36**10).to_s(36) + '@test.com'}
    password_digest BCrypt::Password.create('secret', cost: 4)
    activated true

    trait :admin do
      is_admin true
    end
  end
end

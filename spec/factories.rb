FactoryGirl.define do
  sequence(:username) {|n| "Name#{n}"}

  factory :user do
    username
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
    beer
    user
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end
end
FactoryGirl.define do
  factory :address do
    street "1234 Street"
    city "city"
    state "ST"
    zip "12345"
    user
  end
end
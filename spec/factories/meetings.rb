FactoryBot.define do
  factory :meeting do
    date { '2018-10-01 21:46:22' }
    start_session { Faker::Date.between(DateTime.now - 3, DateTime.now) }
    end_session { Faker::Date.between(DateTime.now - 1, DateTime.now) }
    sequence(:note) { |n| "Note#{n}" }
  end
end

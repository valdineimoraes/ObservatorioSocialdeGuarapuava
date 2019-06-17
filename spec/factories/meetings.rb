FactoryBot.define do
  factory :meeting do
    date { '2018-10-01 21:46:22' }
    start_session { Faker::Date.between(DateTime.now.in_time_zone - 3, DateTime.now.in_time_zone) }
    end_session { Faker::Date.between(DateTime.now.in_time_zone - 1, DateTime.now.in_time_zone) }
    sequence(:note) { |n| "Note#{n}" }
  end
end

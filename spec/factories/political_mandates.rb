

FactoryBot.define do
  factory :political_mandate do
    first_period { '2019-03-18 08:00:15' }
    final_period { '2019-09-18 08:00:15' }
    sequence(:description) { |n| "Nome#{n}"}
  end
end

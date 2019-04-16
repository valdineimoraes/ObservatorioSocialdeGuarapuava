

FactoryBot.define do
  factory :political_mandate do
    sequence(:description) { |n| "Nome#{n}"}
    first_period { '2019-03-18 08:00:15' }
    final_period { '2019-09-18 08:00:15' }
  end
end

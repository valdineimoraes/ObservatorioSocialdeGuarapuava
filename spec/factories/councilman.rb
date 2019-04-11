# frozen_string_literal: true

FactoryBot.define do
  factory :councilman do
    sequence(:name) { |n| "Nome#{n}"}
    sequence(:nickname) { |n| "Apelido#{n}"}
    sequence(:office) { |n| "Cargo#{n}"}
    sequence(:political_party) { |n| "Partido#{n}"}

    first_period { '2019-03-18' }
    final_period { '2019-09-18' }
    sequence(:description) { |n| "Nome#{n}"}
  end
end

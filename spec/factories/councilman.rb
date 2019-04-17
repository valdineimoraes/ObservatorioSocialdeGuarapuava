# frozen_string_literal: true

FactoryBot.define do
  factory :councilman do
    sequence(:name) { |n| "Nome#{n}" }
    sequence(:nickname) { |n| "Apelido#{n}" }
    sequence(:office) { |n| "Cargo#{n}" }
    sequence(:political_party) { |n| "Partido#{n}" }
    political_mandate
  end
end

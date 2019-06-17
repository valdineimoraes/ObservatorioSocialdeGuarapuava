# frozen_string_literal: true

FactoryBot.define do
  factory :councilman do
    sequence(:name) { Faker::Name.name  }
    sequence(:nickname) { Faker::Name.unique.last_name }
    sequence(:office) { Faker::Job.field }
    sequence(:political_party) { Faker::Name.initials }
    political_mandate
  end
end

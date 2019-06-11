FactoryBot.define do
  factory :project_kind do
    sequence(:kind) { Faker::Commerce.unique.material }
    sequence(:description) { Faker::Lorem.paragraph(1) }
  end
end
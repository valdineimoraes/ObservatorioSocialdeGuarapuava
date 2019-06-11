FactoryBot.define do
  factory :project do
    meeting
    councilman
    sequence(:name) { Faker::Hipster.sentence }
    project_kind
    sequence(:description) { Faker::Lorem.paragraph(2) }
  end
end

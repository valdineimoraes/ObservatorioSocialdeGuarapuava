FactoryBot.define do
  factory :project do
    meeting
    councilman
    sequence(:name) { |n| "Nome#{n}" }
    project_kind
    sequence(:description) { |n| "Descricao#{n}" }
  end
end

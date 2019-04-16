
FactoryBot.define do
  factory :project_kind do
    sequence(:kind) { |n| "Tipo#{n}" }
    sequence(:description) {|n| "Descricao#{n}" }
  end
end
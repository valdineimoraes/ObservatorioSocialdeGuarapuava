class ProjectKind < ApplicationRecord
  scope :search, ->(query) { where('kind like ?', "%#{query}%") }

  validates :kind, presence: true, uniqueness: true
end

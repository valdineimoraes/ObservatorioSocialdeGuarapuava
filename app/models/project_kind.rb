class ProjectKind < ApplicationRecord
  scope :search, ->(query) { where('kind like ?', "%#{query}%") }

  has_many :projects, dependent: :destroy

  validates :kind, presence: true, uniqueness: true
end

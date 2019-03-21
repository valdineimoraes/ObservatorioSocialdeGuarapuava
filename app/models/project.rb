class Project < ApplicationRecord
  scope :search, ->(query) { where('name like ?', "%#{query}%") }

  enum result: %i[approved retired postponed rejected filed]

  belongs_to :meeting
  belongs_to :project_kind
  belongs_to :councilman

  has_many :votes, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :votes

  has_many :councilmen, through: :votes, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :councilman_id, :meeting_id, :project_kind_id, presence: true
end

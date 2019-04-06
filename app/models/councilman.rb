class Councilman < ApplicationRecord
  scope :search, ->(query) { where('name like ?', "%#{query}%") }

  enum political_position: %i[opposition situation]
  validates :name, :nickname, presence: true, uniqueness: true
  validates :political_position, :political_party, presence: true

  belongs_to :political_mandate

  has_many :projects, dependent: :destroy
  has_many :session_councilmen, dependent: :destroy
  has_many :meetings, through: :session_councilmen, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
end

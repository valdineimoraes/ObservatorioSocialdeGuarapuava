class Councilman < ApplicationRecord
  scope :search, ->(query) { where('name like ?', "%#{query}%") }

  validates :name, :nickname, presence: true, uniqueness: true
  validates :political_mandate, presence: true

  belongs_to :political_mandate

  has_many :votes, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :session_councilmen, dependent: :destroy
  has_many :meetings, through: :session_councilmen, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
end

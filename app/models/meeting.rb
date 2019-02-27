class Meeting < ApplicationRecord
  has_many :projects, dependent: :destroy

  has_many :session_councilmen, inverse_of: :meeting
  accepts_nested_attributes_for :session_councilmen

  has_many :councilmen, :through => :session_councilmen, dependent: :destroy


  validates :date, presence: true, uniqueness: true
  

  def formatted_date
    date.to_time.strftime("%d/%m/%Y")
  end
end

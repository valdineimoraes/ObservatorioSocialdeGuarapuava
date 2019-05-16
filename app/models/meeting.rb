class Meeting < ApplicationRecord

  has_many :projects, dependent: :destroy

  has_many :session_councilmen, inverse_of: :meeting
  accepts_nested_attributes_for :session_councilmen

  has_many :councilmen, through: :session_councilmen, dependent: :destroy

  validates :date, presence: true, uniqueness: true

  validate :hour_period

  def hour_period
    errors.add(:start_session, I18n.t('errors.messages.date.less_hour')) if
        !end_session.nil? && start_session >= end_session
  end

  def formatted_date
    date.to_time.strftime('%d/%m/%Y')
  end
end

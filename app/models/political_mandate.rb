class PoliticalMandate < ApplicationRecord
  validates :first_period, presence: true
  validates :final_period, presence: true

  has_many :councilman, dependent: :destroy

  validate :date_period

  def date_period
    errors.add(:first_period, I18n.t('errors.messages.date.less_thee')) if
      !final_period.nil? && first_period >= final_period
  end

end

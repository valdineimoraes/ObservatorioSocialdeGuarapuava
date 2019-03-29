class PoliticalMandate < ApplicationRecord
  validates :first_period, presence: true
  validates :final_period, presence: true

  has_many :councilman, dependent: :destroy

  validate :date_period

  def date_period
    errors.add(:first_period, I18n.t('errors.messages.date.less_thee')) if
      !final_period.nil? && first_period >= final_period
  end

  def self.political_mandate_to_select
    mandates = PoliticalMandate.includes(:councilman).order('mandates.description ASC')
    mandates.map { |p| ["#{p.description}", p.id] }
  end

end

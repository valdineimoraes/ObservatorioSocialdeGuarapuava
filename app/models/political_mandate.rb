class PoliticalMandate < ApplicationRecord
  scope :search, ->(query) { where('description like ?', "%#{query}%") }

  validates :first_period, :description, :final_period, presence: true

  has_many :councilmen, dependent: :destroy

  validate :date_period

  def date_period
    errors.add(:first_period, I18n.t('errors.messages.date.less_thee')) if
      !final_period.nil? && first_period >= final_period
  end

  def formatted_date
    date.to_time.strftime('%d/%m/%Y')
  end
end

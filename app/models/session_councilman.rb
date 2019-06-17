class SessionCouncilman < ApplicationRecord
  belongs_to :meeting
  belongs_to :councilman

  # validate :hour_presents

  def hour_presents
    errors.add(:arrival, I18n.t('errors.messages.date.less_hour_presents')) if
        !arrival.nil? && arrival >= leaving
  end
end

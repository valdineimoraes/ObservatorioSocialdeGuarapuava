class Vote < ApplicationRecord
  enum vote: %i[favorable contrary abstention absent], _prefix: :vote
  belongs_to :project
  belongs_to :councilman

  def self.vote_for_select
    votes.map do |v, _|
      [I18n.t("enums.votes.vote.#{v}"), v]
    end
  end
end

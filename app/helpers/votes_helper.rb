# frozen_string_literal: true

module VotesHelper
  def councilman_value(v, c, attribute)
    vote = v.votes.find_by(councilman_id: c.id)
    return '' if vote.nil?

    vote.send(attribute)
  end
end

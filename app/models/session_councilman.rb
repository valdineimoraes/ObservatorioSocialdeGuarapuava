# frozen_string_literal: true

class SessionCouncilman < ApplicationRecord
  belongs_to :meeting
  belongs_to :councilman
end

# frozen_string_literal: true

class Vote < ApplicationRecord
  enum vote: %i[favorable contrary abstention absent]
  belongs_to :project
  belongs_to :councilman
end

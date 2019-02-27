class Vote < ApplicationRecord
  enum vote: [:favorable, :contrary, :abstention, :absent]
  belongs_to :project
  belongs_to :councilman
end

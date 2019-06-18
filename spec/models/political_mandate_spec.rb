require 'rails_helper'

RSpec.describe PoliticalMandate, type: :model do
  describe 'validates' do
    subject { create(:political_mandate) }

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:first_period) }
    it { is_expected.to validate_presence_of(:final_period) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:councilmen).dependent(:destroy) }
  end
end

require 'rails_helper'

RSpec.describe Councilman, type: :model do
  describe 'validates' do
    it {is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_uniqueness_of(:name)}
    it {is_expected.to validate_presence_of(:nickname)}
    it { is_expected.to validate_uniqueness_of(:nickname)}
    it {is_expected.to validate_presence_of(:political_mandate)}
  end

  describe 'associations' do
    it {is_expected.to belong_to(:political_mandate)}
    
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:projects).dependent(:destroy) }
    it { is_expected.to have_many(:session_councilmen).dependent(:destroy) }
    it { is_expected.to have_many(:meetings).through(:session_councilmen).dependent(:destroy) }
  end
end
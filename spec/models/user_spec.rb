require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:username)}

  end

  # describe 'relationships' do
  #   it { should have_many(:authors)}
  # end
end

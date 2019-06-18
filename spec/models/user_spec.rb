require 'spec_helper'

describe Spree::User do
  let!(:user) { create(:user) }
  let!(:address) { create(:address, user: user) }
  let!(:address2) { create(:address, user: user) }

  describe 'user has_many addresses' do
    it 'should have many addresses' do
      expect(user).to respond_to(:addresses)
      expect(user.addresses.count).to eq(2)
    end
  end
end

require 'spec_helper'

describe Spree::Order do
  describe 'mass attribute assignment for bill_address_id, ship_address_id' do
    let(:order) { create(:order) }
    let(:address) { create(:address, user: order.user) }

    it 'should be able to mass assign bill_address_id' do
      order.update_attributes(bill_address_id: address.id)
      expect(order.bill_address_id).to eq(address.id)
    end

    it 'should be able to mass assign ship_address_id' do
      order.update_attributes(ship_address_id: address.id)
      expect(order.ship_address_id).to eq(address.id)
    end
  end

  describe 'Create order with the same bill & ship addresses' do
    let(:address) { create(:address) }

    it 'should have equal ids when set ids' do
      order = create(:order, bill_address_id: address.id, ship_address_id: address.id)

      expect(order.reload.bill_address_id).to eq(order.ship_address_id)
    end

    it 'should have equal ids when option use_billing is active' do
      order  = create(:order, use_billing: true,
                               bill_address_id: address.id,
                               ship_address_id: nil)

      expect(order.reload.bill_address_id).to eq(order.reload.ship_address_id)
    end
  end
end

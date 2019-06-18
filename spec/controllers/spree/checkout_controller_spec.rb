require 'spec_helper'

RSpec.describe Spree::CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:order) do
    order = create(:order, bill_address_id: nil, ship_address_id: nil, user: user)
    order.contents.add(create(:product, sku: 'Demo-SKU').master, 1)
    order.save
    order
  end

  let(:token) { 'some_token' }
  # let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }
  # let(:order) { create(:order_with_totals) }

  let(:address_params) do
    address = build(:address)
    address.attributes.except("created_at", "updated_at")
  end

  before do
    # assigns(:address, address)
    # assigns(:order, order)
    allow(controller).to receive_messages(try_spree_current_user: user)
    allow(controller).to receive_messages spree_current_user: user
    allow(controller).to receive_messages current_store: order.store
    allow(controller).to receive_messages current_order: order
  end

  stub_authorization!

  # before(:each) do
  #   user = create(:user)
  #   @address = create(:address, user: user)

  #   @order = create(:order, bill_address_id: nil, ship_address_id: nil)
  #   @order.contents.add(create(:product, sku: 'Demo-SKU').master, 1)
  #   @order.user = user
  #   @address.user = @order.user
  #   @order.save
  #   allow(controller).to receive(:spree_current_user).and_return(@order.user)
  #   allow(controller).to receive(:current_store).and_return(@order.store)
  # end

  # before(:each) do
  #   allow(controller).to receive(:spree_current_user).and_return(user)
  # end

  describe 'on address step' do
    it 'set equal address ids' do
      put :update, params: {
        state: 'address',
        order: {
          bill_address_id: address.id,
          ship_address_id: address.id
        }
      }

      expect(order.bill_address).to be_present
      expect(order.ship_address).to be_present
      expect(order.reload.bill_address_id).to eq address.id
      expect(order.reload.bill_address_id).to eq order.ship_address_id
    end

    it 'set bill_address_id and use_billing' do
      put :update, params: {
        state: 'address',
        order: {
          bill_address_id: address.id,
          use_billing: true
        }
      }

      expect(order.bill_address).to be_present
      expect(order.ship_address).to be_present
      expect(order.bill_address_id).to eq address.id
      expect(order.bill_address_id).to eq order.ship_address_id
    end

    it 'set address attributes' do
      # clone the unassigned address for easy creation of valid data
      # remove blacklisted attributes to avoid mass-assignment error
      cloned_attributes = address.clone.attributes.select do |k, _v|
        !%w(id created_at deleted_at updated_at).include?(k)
      end

      post :update, params: {
        state: 'address',
        order: {
          bill_address_attributes: cloned_attributes,
          ship_address_attributes: cloned_attributes
        }
      }

      expect(order.bill_address).to_not be_nil
      expect(order.ship_address).to_not be_nil
      expect(order.bill_address_id).to eq order.ship_address_id
    end
  end
end

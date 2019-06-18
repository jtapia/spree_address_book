require 'spec_helper'

describe Spree::Address do
  let(:address) { build(:address) }
  let(:address2) { create(:address) }
  let(:order) { create(:completed_order_with_totals) }
  let(:user) { create(:user) }
  let(:attributes) { [:firstname, :address1, :city, :country_id, :zipcode, :phone] }
  let(:address_string) { "#{address.full_name}<br/>#{address.company}<br/>#{address.address1}<br/>#{address.address2}<br/>#{address.city}, #{address.state ? address.state.abbr : address.state_name} #{address.zipcode}<br/>#{address.country}" }

  before { order.update_attribute(:bill_address, address2) }

  it 'has required attributes' do
    expect(Spree::Address.required_fields).to eq(attributes)
  end

  it 'is editable' do
    expect(address).to be_editable
  end

  it 'can be deleted' do
    expect(address).to be_can_be_deleted
  end

  it "isn't editable when there is an associated order" do
    expect(address2).to_not be_editable
  end

  it "can't be deleted when there is an associated order" do
    expect(address2).to_not be_can_be_deleted
  end

  it 'is displayed as string' do
    expect(address.to_s).to eq address_string.html_safe
  end

  it 'is destroyed without saving used' do
    address.destroy
    expect(Spree::Address.where(['id = (?)', address.id])).to be_empty
  end

  it 'is destroyed deleted timestamp' do
    address2.destroy
    expect(Spree::Address.where(['id = (?)', address2.id])).to_not be_empty
  end
end

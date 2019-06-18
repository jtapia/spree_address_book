# frozen_string_literal: true

module SolidusAddressBook
  class Configuration < Spree::Preferences::Configuration
    preference :disable_bill_address, :boolean, default: false
    preference :alternative_billing_phone, :boolean, default: false # Request extra phone for billing addr
  end
end

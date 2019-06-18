(Spree::PermittedAttributes.class_variable_get("@@address_attributes") << [
  :user_id, :deleted_at
]).flatten!

module AddressDecorator
  extend ActiveSupport::Concern

  included do
    prepend(InstanceMethods)

    # DB_ONLY_ATTRS = %w(id updated_at created_at deleted_at)

    def self.required_fields
      Spree::Address.validators.map do |v|
        v.kind_of?(ActiveModel::Validations::PresenceValidator) ? v.attributes : []
      end.flatten
    end
  end

  module InstanceMethods
    # TODO: look into if this is actually needed. I don't want to override methods unless it is really needed
    # can modify an address if it's not been used in an order
    def same_as?(other)
      return false if other.nil?

      attributes.except('id', 'updated_at', 'created_at', 'user_id') == other.attributes.except('id', 'updated_at', 'created_at', 'user_id')
    end

    # can modify an address if it's not been used in an completed order
    def editable?
      new_record? || (Spree::Order.complete.where("bill_address_id = ? OR ship_address_id = ?", self.id, self.id).count == 0)
    end

    def can_be_deleted?
      Spree::Order.where("bill_address_id = ? OR ship_address_id = ?", self.id, self.id).count == 0
    end

    def to_s
      [
        full_name,
        company.to_s,
        address1.to_s,
        address2.to_s,
        "#{city}, #{state ? state.abbr : state_name} #{zipcode}",
        country.to_s
      ].reject(&:empty?).join("<br/>").html_safe
    end

    # UPGRADE_CHECK if future versions of spree have a custom destroy function, this will break
    def destroy
      if can_be_deleted?
        super
      else
        update_column :deleted_at, DateTime.now
      end
    end

    def check
      attrs = attributes.except('id', 'updated_at', 'created_at')
      the_same_address = user.addresses.where(attrs).first
      the_same_address ? the_same_address : self
    end
  end
end

Spree::Address.include(SolidusAddressBook::Address)
Spree::Address.include(AddressDecorator)

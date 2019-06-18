class AddUserIdAndDeletedAtToAddresses < SolidusSupport::Migration[4.2]
  def self.up
    add_column :spree_addresses, :deleted_at, :datetime
    add_reference :spree_addresses, :user, index: true
  end

  def self.down
    remove_column :spree_addresses, :deleted_at
    remove_reference :spree_addresses, :user
  end
end

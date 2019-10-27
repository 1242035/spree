# this migration does the same as this two from ViaucoAddressBook
# https://github.com/viauco-contrib/viauco_address_book/blob/master/db/migrate/20110302102208_add_user_id_and_deleted_at_to_addresses.rb
# https://github.com/viauco-contrib/viauco_address_book/blob/master/db/migrate/20170405133031_add_missing_indexes.rb
class AddUserIdAndDeletedAtToViaucoAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :viauco_addresses, :user_id, :integer unless column_exists?(:viauco_addresses, :user_id)
    add_index :viauco_addresses, :user_id unless index_exists?(:viauco_addresses, :user_id)

    add_column :viauco_addresses, :deleted_at, :datetime unless column_exists?(:viauco_addresses, :deleted_at)
    add_index :viauco_addresses, :deleted_at unless index_exists?(:viauco_addresses, :deleted_at)
  end
end

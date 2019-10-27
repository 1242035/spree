class AddAdditionalStoreFields < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_stores, :code, :string unless column_exists?(:viauco_stores, :code)
    add_column :viauco_stores, :default, :boolean, default: false, null: false unless column_exists?(:viauco_stores, :default)
    add_index :viauco_stores, :code
    add_index :viauco_stores, :default
  end
end

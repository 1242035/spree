class AddLockVersionToVariant < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_variants, :lock_version, :integer, default: 0
  end
end

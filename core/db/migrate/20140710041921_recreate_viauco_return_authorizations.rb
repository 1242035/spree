class RecreateViaucoReturnAuthorizations < ActiveRecord::Migration[4.2]
  def up
    # If the app has any legacy return authorizations then rename the table & columns and leave them there
    # for the viauco_legacy_return_authorizations extension to pick up with.
    # Otherwise just drop the tables/columns as they are no longer used in stock viauco.  The viauco_legacy_return_authorizations
    # extension will recreate these tables for dev environments & etc as needed.
    if Viauco::ReturnAuthorization.exists?
      rename_table :viauco_return_authorizations, :viauco_legacy_return_authorizations
      rename_column :viauco_inventory_units, :return_authorization_id, :legacy_return_authorization_id
    else
      drop_table :viauco_return_authorizations
      remove_column :viauco_inventory_units, :return_authorization_id
    end

    Viauco::Adjustment.where(source_type: 'Viauco::ReturnAuthorization').update_all(source_type: 'Viauco::LegacyReturnAuthorization')

    # For now just recreate the table as it was.  Future changes to the schema (including dropping "amount") will be coming in a
    # separate commit.
    create_table :viauco_return_authorizations do |t|
      t.string   "number"
      t.string   "state"
      t.decimal  "amount", precision: 10, scale: 2, default: 0.0, null: false
      t.integer  "order_id"
      t.text     "reason"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "stock_location_id"
    end

  end

  def down
    drop_table :viauco_return_authorizations

    Viauco::Adjustment.where(source_type: 'Viauco::LegacyReturnAuthorization').update_all(source_type: 'Viauco::ReturnAuthorization')

    if data_source_exists?(:viauco_legacy_return_authorizations)
      rename_table :viauco_legacy_return_authorizations, :viauco_return_authorizations
      rename_column :viauco_inventory_units, :legacy_return_authorization_id, :return_authorization_id
    else
      create_table :viauco_return_authorizations do |t|
        t.string   "number"
        t.string   "state"
        t.decimal  "amount", precision: 10, scale: 2, default: 0.0, null: false
        t.integer  "order_id"
        t.text     "reason"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "stock_location_id"
      end
      add_column :viauco_inventory_units, :return_authorization_id, :integer, after: :shipment_id
      add_index :viauco_inventory_units, :return_authorization_id
    end
  end
end

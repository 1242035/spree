class AddMoreIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_payment_methods, [:id, :type]
    add_index :viauco_calculators, [:id, :type]
    add_index :viauco_calculators, [:calculable_id, :calculable_type]
    add_index :viauco_payments, :payment_method_id
    add_index :viauco_promotion_actions, [:id, :type]
    add_index :viauco_promotion_actions, :promotion_id
    add_index :viauco_promotions, [:id, :type]
    add_index :viauco_option_values, :option_type_id
    add_index :viauco_shipments, :stock_location_id
  end
end

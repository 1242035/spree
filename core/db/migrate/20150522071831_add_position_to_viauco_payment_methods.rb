class AddPositionToViaucoPaymentMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_payment_methods, :position, :integer, default: 0
  end
end

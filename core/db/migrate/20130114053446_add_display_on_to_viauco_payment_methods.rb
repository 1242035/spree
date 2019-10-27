class AddDisplayOnToViaucoPaymentMethods < ActiveRecord::Migration[4.2]
  def self.up
    add_column :viauco_payment_methods, :display_on, :string
  end

  def self.down
    remove_column :viauco_payment_methods, :display_on
  end
end

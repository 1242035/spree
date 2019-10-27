class AddAutoCaptureToPaymentMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_payment_methods, :auto_capture, :boolean
  end
end

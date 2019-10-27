class RemoveEnvironmentFromPaymentMethod < ActiveRecord::Migration[4.2]
  def up
    Viauco::PaymentMethod.where('environment != ?', Rails.env).update_all(active: false)
    remove_column :viauco_payment_methods, :environment
  end
end

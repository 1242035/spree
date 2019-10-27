class ChangeViaucoReturnAuthorizationAmountPrecision < ActiveRecord::Migration[4.2]
   def change
   
    change_column :viauco_return_authorizations, :amount,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
                                   
  end
end

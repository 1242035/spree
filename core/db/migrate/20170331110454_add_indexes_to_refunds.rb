class AddIndexesToRefunds < ActiveRecord::Migration[5.0]
  def change
    add_index :viauco_refunds, :payment_id
    add_index :viauco_refunds, :reimbursement_id
  end
end

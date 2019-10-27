class CreateViaucoRefundReasons < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_refund_reasons do |t|
      t.string :name
      t.boolean :active, default: true
      t.boolean :mutable, default: true

      t.timestamps null: false, precision: 6
    end

    add_column :viauco_refunds, :refund_reason_id, :integer
    add_index :viauco_refunds, :refund_reason_id, name: 'index_refunds_on_refund_reason_id'
  end
end

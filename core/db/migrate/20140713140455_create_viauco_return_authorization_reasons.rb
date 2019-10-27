class CreateViaucoReturnAuthorizationReasons < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_return_authorization_reasons do |t|
      t.string :name
      t.boolean :active, default: true
      t.boolean :mutable, default: true

      t.timestamps null: false, precision: 6
    end

    reversible do |direction|
      direction.up do
        Viauco::ReturnAuthorizationReason.create!(name: 'Better price available')
        Viauco::ReturnAuthorizationReason.create!(name: 'Missed estimated delivery date')
        Viauco::ReturnAuthorizationReason.create!(name: 'Missing parts or accessories')
        Viauco::ReturnAuthorizationReason.create!(name: 'Damaged/Defective')
        Viauco::ReturnAuthorizationReason.create!(name: 'Different from what was ordered')
        Viauco::ReturnAuthorizationReason.create!(name: 'Different from description')
        Viauco::ReturnAuthorizationReason.create!(name: 'No longer needed/wanted')
        Viauco::ReturnAuthorizationReason.create!(name: 'Accidental order')
        Viauco::ReturnAuthorizationReason.create!(name: 'Unauthorized purchase')
      end
    end

    add_column :viauco_return_authorizations, :return_authorization_reason_id, :integer
    add_index :viauco_return_authorizations, :return_authorization_reason_id, name: 'index_return_authorizations_on_return_authorization_reason_id'
  end
end

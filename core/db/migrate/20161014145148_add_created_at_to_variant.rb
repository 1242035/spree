class AddCreatedAtToVariant < ActiveRecord::Migration[5.0]
  def change
    add_column :viauco_variants, :created_at, :datetime
    Viauco::Variant.reset_column_information
    Viauco::Variant.unscoped.where.not(updated_at: nil).update_all('created_at = updated_at')
    Viauco::Variant.unscoped.where(updated_at: nil).update_all(created_at: Time.current, updated_at: Time.current)
  end
end

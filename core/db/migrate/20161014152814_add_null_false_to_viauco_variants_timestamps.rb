class AddNullFalseToViaucoVariantsTimestamps < ActiveRecord::Migration[5.0]
  def change
    change_column_null :viauco_variants, :created_at, false
    change_column_null :viauco_variants, :updated_at, false
  end
end

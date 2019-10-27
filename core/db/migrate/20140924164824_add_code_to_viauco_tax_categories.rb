class AddCodeToViaucoTaxCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_tax_categories, :tax_code, :string
  end
end

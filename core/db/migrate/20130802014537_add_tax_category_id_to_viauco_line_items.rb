class AddTaxCategoryIdToViaucoLineItems < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :tax_category_id, :integer
  end
end

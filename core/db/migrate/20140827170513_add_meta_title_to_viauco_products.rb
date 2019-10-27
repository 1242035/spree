class AddMetaTitleToViaucoProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :viauco_products do |t|
      t.string   :meta_title
    end
  end
end

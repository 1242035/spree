class AddIndexForPrototypeIdToPrototypeTaxons < ActiveRecord::Migration[5.0]
  def change
    add_index :viauco_prototype_taxons, :prototype_id
  end
end

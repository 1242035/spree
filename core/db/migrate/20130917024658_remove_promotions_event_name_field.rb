class RemovePromotionsEventNameField < ActiveRecord::Migration[4.2]
  def change
    remove_column :viauco_promotions, :event_name, :string
  end
end

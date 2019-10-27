class AddReceptionAndAcceptanceStatusToReturnItems < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_return_items, :reception_status, :string
    add_column :viauco_return_items, :acceptance_status, :string
  end
end

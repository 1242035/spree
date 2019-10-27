class RemoveViaucoConfigurations < ActiveRecord::Migration[4.2]
  def up
    drop_table "viauco_configurations"
  end

  def down
    create_table "viauco_configurations", force: true do |t|
      t.string   "name"
      t.string   "type",       limit: 50
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "viauco_configurations", ["name", "type"], name: "index_viauco_configurations_on_name_and_type"
  end
end

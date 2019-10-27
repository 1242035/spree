class DropViaucoMailMethods < ActiveRecord::Migration[4.2]
  def up
    drop_table :viauco_mail_methods
  end

  def down
    create_table(:viauco_mail_methods) do |t|
      t.string :environment
      t.boolean :active
    end
  end
end

class AddIndexToUserViaucoApiKey < ActiveRecord::Migration[4.2]
  def change
    unless defined?(User)
      add_index :viauco_users, :viauco_api_key
    end
  end
end

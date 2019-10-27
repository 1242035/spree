class RenameApiKeyToViaucoApiKey < ActiveRecord::Migration[4.2]
  def change
    unless defined?(User)
      rename_column :viauco_users, :api_key, :viauco_api_key
    end
  end
end

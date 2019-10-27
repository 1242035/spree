class AddIndexToRoleUsers < ActiveRecord::Migration[5.0]
  def change

    duplicates = Viauco::RoleUser.group(:role_id, :user_id).having('sum(1) > 1').size

    duplicates.each do |f|
      role_id, user_id = f.first
      count = f.last - 1 # we want to leave one record
      roles = Viauco::RoleUser.where(role_id: role_id, user_id: user_id).last(count)
      roles.map(&:destroy)
    end

    if index_exists? :viauco_role_users, [:role_id, :user_id]
      remove_index :viauco_role_users, [:role_id, :user_id]
      add_index :viauco_role_users, [:role_id, :user_id], unique: true
    end
  end
end

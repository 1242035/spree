class MoveOrderTokenFromTokenizedPermission < ActiveRecord::Migration[4.2]
  class Viauco::TokenizedPermission < Viauco::Base
    belongs_to :permissable, polymorphic: true
  end

  def up
    case Viauco::Order.connection.adapter_name
    when 'SQLite'
      Viauco::Order.has_one :tokenized_permission, as: :permissable
      Viauco::Order.includes(:tokenized_permission).each do |o|
        o.update_column :guest_token, o.tokenized_permission.token
      end
    when 'Mysql2', 'MySQL'
      execute "UPDATE viauco_orders, viauco_tokenized_permissions
               SET viauco_orders.guest_token = viauco_tokenized_permissions.token
               WHERE viauco_tokenized_permissions.permissable_id = viauco_orders.id
                  AND viauco_tokenized_permissions.permissable_type = 'Viauco::Order'"
    else
      execute "UPDATE viauco_orders
               SET guest_token = viauco_tokenized_permissions.token
               FROM viauco_tokenized_permissions
               WHERE viauco_tokenized_permissions.permissable_id = viauco_orders.id
                  AND viauco_tokenized_permissions.permissable_type = 'Viauco::Order'"
    end
  end

  def down
  end
end

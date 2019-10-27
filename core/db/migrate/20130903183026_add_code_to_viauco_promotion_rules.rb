class AddCodeToViaucoPromotionRules < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_promotion_rules, :code, :string
  end
end

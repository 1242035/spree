class AddShippingCategoryToShippingMethodsAndProducts < ActiveRecord::Migration[4.2]
  def up
    default_category = Viauco::ShippingCategory.first
    default_category ||= Viauco::ShippingCategory.create!(name: "Default")

    Viauco::ShippingMethod.all.each do |method|
      method.shipping_categories << default_category if method.shipping_categories.blank?
    end

    Viauco::Product.where(shipping_category_id: nil).update_all(shipping_category_id: default_category.id)
  end

  def down
  end
end

class AddUniqueIndexOnNumberToViaucoOrders < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:viauco_orders, :number, unique: true)
      numbers = Viauco::Order.group(:number).having('sum(1) > 1').pluck(:number)
      orders = Viauco::Order.where(number: numbers)

      orders.find_each do |order|
        order.number = order.class.number_generator.method(:generate_permalink).call(order.class)
        order.save
      end

      remove_index :viauco_orders, :number if index_exists?(:viauco_orders, :number)
      add_index :viauco_orders, :number, unique: true
    end
  end
end

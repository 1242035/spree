class AddUniqueIndexOnNumberToViaucoPayments < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:viauco_payments, :number, unique: true)
      # default scope in Viauco::Payment disturbs Postgres, hence `unscoped` is needed.
      numbers = Viauco::Payment.unscoped.group(:number).having('sum(1) > 1').pluck(:number)
      payments = Viauco::Payment.where(number: numbers)

      payments.find_each do |payment|
        payment.number = payment.class.number_generator.method(:generate_permalink).call(payment.class)
        payment.save
      end

      remove_index :viauco_payments, :number if index_exists?(:viauco_payments, :number)
      add_index :viauco_payments, :number, unique: true
    end
  end
end

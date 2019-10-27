class EnsurePaymentsHaveNumbers < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_payments, :number unless index_exists?(:viauco_payments, :number)
    Viauco::Payment.where(number: nil).find_each do |payment|
      begin
        payment.save! # to generate a new number we need to save the record
      rescue ActiveRecord::RecordNotSaved
        Rails.logger.error("Payment with ID = #{payment.id} couldn't be saved")
        Rails.logger.error(payment.errors.full_messages.to_sentence)
      end
    end
  end
end

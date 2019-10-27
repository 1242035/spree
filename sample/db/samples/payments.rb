# create payments based on the totals since they can't be known in YAML (quantities are random)
method = Viauco::PaymentMethod.where(name: 'Credit Card', active: true).first

# Hack the current method so we're able to return a gateway without a RAILS_ENV
Viauco::Gateway.class_eval do
  def self.current
    Viauco::Gateway::Bogus.new
  end
end

# This table was previously called viauco_creditcards, and older migrations
# reference it as such. Make it explicit here that this table has been renamed.
Viauco::CreditCard.table_name = 'viauco_credit_cards'

credit_card = Viauco::CreditCard.where(cc_type: 'visa',
                                      month: 12,
                                      year: 2.years.from_now.year,
                                      last_digits: '1111',
                                      name: 'Author',
                                      gateway_customer_profile_id: 'BGS-1234').first_or_create!

Viauco::Order.all.each_with_index do |order, _index|
  order.update_with_updater!
  payment = order.payments.where(amount: BigDecimal(order.total, 4),
                                 source: credit_card.clone,
                                 payment_method: method).first_or_create!

  payment.update_columns(state: 'pending', response_code: '12345')
end

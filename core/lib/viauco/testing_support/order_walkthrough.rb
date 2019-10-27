class OrderWalkthrough
  def self.up_to(state)
    # A default store must exist to provide store settings
    FactoryBot.create(:store) unless Viauco::Store.exists?

    # A payment method must exist for an order to proceed through the Address state
    unless Viauco::PaymentMethod.exists?
      FactoryBot.create(:check_payment_method)
    end

    # Need to create a valid zone too...
    zone = FactoryBot.create(:zone)
    country = FactoryBot.create(:country)
    zone.members << Viauco::ZoneMember.create(zoneable: country)
    country.states << FactoryBot.create(:state, country: country)

    # A shipping method must exist for rates to be displayed on checkout page
    unless Viauco::ShippingMethod.exists?
      FactoryBot.create(:shipping_method).tap do |sm|
        sm.calculator.preferred_amount = 10
        sm.calculator.preferred_currency = Viauco::Config[:currency]
        sm.calculator.save
      end
    end

    order = Viauco::Order.create!(email: 'viauco@example.com')
    add_line_item!(order)
    order.next!

    end_state_position = states.index(state.to_sym)
    states[0...end_state_position].each do |state|
      send(state, order)
    end

    order
  end

  private

  def self.add_line_item!(order)
    FactoryBot.create(:line_item, order: order)
    order.reload
  end

  def self.address(order)
    order.bill_address = FactoryBot.create(:address, country_id: Viauco::Zone.global.members.first.zoneable.id)
    order.ship_address = FactoryBot.create(:address, country_id: Viauco::Zone.global.members.first.zoneable.id)
    order.next!
  end

  def self.delivery(order)
    order.next!
  end

  def self.payment(order)
    order.payments.create!(payment_method: Viauco::PaymentMethod.first, amount: order.total)
    # TODO: maybe look at some way of making this payment_state change automatic
    order.payment_state = 'paid'
    order.next!
  end

  def self.complete(_order)
    # noop?
  end

  def self.states
    [:address, :delivery, :payment, :complete]
  end
end

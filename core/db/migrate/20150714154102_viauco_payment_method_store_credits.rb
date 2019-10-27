class ViaucoPaymentMethodStoreCredits < ActiveRecord::Migration[4.2]
  def up
    # Reload to pick up new position column for acts_as_list
    Viauco::PaymentMethod.reset_column_information
    Viauco::PaymentMethod::StoreCredit.find_or_create_by(name: 'Store Credit', description: 'Store Credit',
                                                        active: true, display_on: 'back_end')
  end

  def down
    Viauco::PaymentMethod.find_by(type: 'Viauco::PaymentMethod::StoreCredit', name: 'Store Credit').try(&:destroy)
  end
end

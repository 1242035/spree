require 'spec_helper'

describe Viauco::Order, type: :model do
  let(:order) { create(:order) }

  context '#update_with_updater!' do
    let(:line_items) { [mock_model(Viauco::LineItem, amount: 5)] }

    context 'when there are update hooks' do
      before { Viauco::Order.register_update_hook :foo }

      after { Viauco::Order.update_hooks.clear }

      it 'calls each of the update hooks' do
        expect(order).to receive :foo
        order.update_with_updater!
      end
    end
  end
end

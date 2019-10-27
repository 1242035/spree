require 'spec_helper'

describe 'Shipments', type: :feature do
  stub_authorization!

  let!(:order) { create(:order_ready_to_ship, number: 'R100', state: 'complete', line_items_count: 5) }

  # Regression test for #4025
  context 'a shipment without a shipping method' do
    before do
      order.shipments.each do |s|
        # Deleting the shipping rates causes there to be no shipping methods
        s.shipping_rates.delete_all
      end
    end

    it 'can still be displayed' do
      expect { visit viauco.edit_admin_order_path(order) }.not_to raise_error
    end
  end

  context 'shipping an order', js: true do
    before do
      visit viauco.admin_orders_path
      within_row(1) do
        click_link 'R100'
      end
    end

    it 'can ship a completed order' do
      click_on 'Ship'

      expect(page).to have_content("shipped\npackage")
      expect(order.reload.shipment_state).to eq('shipped')
    end
  end

  context 'moving variants between shipments', js: true do
    before do
      create(:stock_location, name: 'LA')
      visit viauco.admin_orders_path
      within_row(1) do
        click_link 'R100'
      end
    end

    it 'can move a variant to a new and to an existing shipment' do
      expect(order.shipments.count).to eq(1)

      within_row(1) { click_icon :split }
      targetted_select2 'LA', from: '#s2id_item_stock_location'
      click_icon :'save-split'

      expect(page).to have_css('#order-form-wrapper div', id: /^shipment_\d$/).exactly(2).times
      expect(page).to have_css("#shipment_#{order.shipments.first.id}")

      within_row(2) { click_icon :split }
      targetted_select2 "LA(#{order.reload.shipments.last.number})", from: '#s2id_item_stock_location'
      click_icon :save
      wait_for_ajax

      expect(page).to have_css("#shipment_#{order.reload.shipments.last.id}")
    end
  end
end

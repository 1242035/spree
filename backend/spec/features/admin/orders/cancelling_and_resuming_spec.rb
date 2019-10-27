require 'spec_helper'

describe 'Cancelling + Resuming', type: :feature do
  stub_authorization!

  let(:user) { double(id: 123, has_viauco_role?: true, viauco_api_key: 'fake', email: 'viauco@example.com') }
  let(:order) do
    order = create(:order)
    order.update_columns(state: 'complete', completed_at: Time.current)
    order
  end

  before do
    allow_any_instance_of(Viauco::Admin::BaseController).to receive(:try_viauco_current_user).and_return(user)
  end

  it 'can cancel an order' do
    visit viauco.edit_admin_order_path(order.number)
    click_button 'Cancel'
    expect(page).to have_css('.additional-info .state', text: 'canceled')
  end

  context 'with a cancelled order' do
    before do
      order.update_column(:state, 'canceled')
    end

    it 'can resume an order' do
      visit viauco.edit_admin_order_path(order.number)
      click_button 'Resume'
      expect(page).to have_css('.additional-info .state', text: 'resumed')
    end
  end
end

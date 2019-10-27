require 'spec_helper'
describe Viauco::ContentController, type: :controller do
  it 'displays CVV page' do
    get :cvv
    expect(response.response_code).to eq(200)
  end
end

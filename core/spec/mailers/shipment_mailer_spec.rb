require 'spec_helper'
require 'email_spec'

describe Viauco::ShipmentMailer, type: :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before { create(:store) }

  let(:order) { stub_model(Viauco::Order, number: 'R12345') }
  let(:shipping_method) { stub_model(Viauco::ShippingMethod, name: 'USPS') }
  let(:product) { stub_model(Viauco::Product, name: %{The "BEST" product}, sku: 'SKU0001') }
  let(:variant) { stub_model(Viauco::Variant, product: product) }
  let(:line_item) { stub_model(Viauco::LineItem, variant: variant, order: order, quantity: 1, price: 5) }
  let(:shipment) do
    shipment = stub_model(Viauco::Shipment)
    allow(shipment).to receive_messages(line_items: [line_item], order: order)
    allow(shipment).to receive_messages(tracking_url: 'http://track.com/me')
    allow(shipment).to receive_messages(shipping_method: shipping_method)
    shipment
  end

  context ':from not set explicitly' do
    it 'falls back to viauco config' do
      message = Viauco::ShipmentMailer.shipped_email(shipment)
      expect(message.from).to eq([Viauco::Store.current.mail_from_address])
    end
  end

  # Regression test for #2196
  it "doesn't include out of stock in the email body" do
    shipment_email = Viauco::ShipmentMailer.shipped_email(shipment)
    expect(shipment_email.body).not_to include(%q{Out of Stock})
  end

  it 'shipment_email accepts an shipment id as an alternative to an Shipment object' do
    expect(Viauco::Shipment).to receive(:find).with(shipment.id).and_return(shipment)
    expect do
      Viauco::ShipmentMailer.shipped_email(shipment.id).body
    end.not_to raise_error
  end

  context 'emails must be translatable' do
    context 'shipped_email' do
      context 'pt-BR locale' do
        before do
          I18n.enforce_available_locales = false
          pt_br_shipped_email = { viauco: { shipment_mailer: { shipped_email: { dear_customer: 'Caro Cliente,' } } } }
          I18n.backend.store_translations :'pt-BR', pt_br_shipped_email
          I18n.locale = :'pt-BR'
        end

        after do
          I18n.locale = I18n.default_locale
          I18n.enforce_available_locales = true
        end

        specify do
          shipped_email = Viauco::ShipmentMailer.shipped_email(shipment)
          expect(shipped_email).to have_body_text('Caro Cliente,')
        end
      end
    end
  end

  context 'shipped_email' do
    let(:shipped_email) { Viauco::ShipmentMailer.shipped_email(shipment) }

    specify do
      expect(shipped_email).to have_body_text(order.number)
    end

    specify do
      expect(shipped_email).to have_body_text(shipping_method.name)
    end

    specify do
      expect(shipped_email).to have_body_text("href=\"#{shipment.tracking_url}\"")
    end
  end
end

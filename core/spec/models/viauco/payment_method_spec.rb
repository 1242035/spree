require 'spec_helper'

describe Viauco::PaymentMethod, type: :model do
  context 'visibility scopes' do
    before do
      [nil, '', 'both', 'front_end', 'back_end'].each do |display_on|
        Viauco::Gateway::Test.create(
          name: 'Display Both',
          display_on: display_on,
          active: true,
          description: 'foofah'
        )
      end
    end

    it 'has 5 total methods' do
      expect(Viauco::PaymentMethod.count).to eq(5)
    end

    describe '#available' do
      it 'returns all methods available to front-end/back-end' do
        methods = Viauco::PaymentMethod.available
        expect(methods.size).to eq(3)
        expect(methods.pluck(:display_on)).to eq(['both', 'front_end', 'back_end'])
      end
    end

    describe '#available_on_front_end' do
      it 'returns all methods available to front-end' do
        methods = Viauco::PaymentMethod.available_on_front_end
        expect(methods.size).to eq(2)
        expect(methods.pluck(:display_on)).to eq(['both', 'front_end'])
      end
    end

    describe '#available_on_back_end' do
      it 'returns all methods available to back-end' do
        methods = Viauco::PaymentMethod.available_on_back_end
        expect(methods.size).to eq(2)
        expect(methods.pluck(:display_on)).to eq(['both', 'back_end'])
      end
    end
  end

  describe '#auto_capture?' do
    class TestGateway < Viauco::Gateway
      def provider_class
        Provider
      end
    end

    subject { gateway.auto_capture? }

    let(:gateway) { TestGateway.new }

    context 'when auto_capture is nil' do
      before do
        expect(Viauco::Config).to receive('[]').with(:auto_capture).and_return(auto_capture)
      end

      context 'and when Viauco::Config[:auto_capture] is false' do
        let(:auto_capture) { false }

        it 'is false' do
          expect(gateway.auto_capture).to be_nil
          expect(subject).to be false
        end
      end

      context 'and when Viauco::Config[:auto_capture] is true' do
        let(:auto_capture) { true }

        it 'is true' do
          expect(gateway.auto_capture).to be_nil
          expect(subject).to be true
        end
      end
    end

    context 'when auto_capture is not nil' do
      before do
        gateway.auto_capture = auto_capture
      end

      context 'and is true' do
        let(:auto_capture) { true }

        it 'is true' do
          expect(subject).to be true
        end
      end

      context 'and is false' do
        let(:auto_capture) { false }

        it 'is true' do
          expect(subject).to be false
        end
      end
    end
  end
end

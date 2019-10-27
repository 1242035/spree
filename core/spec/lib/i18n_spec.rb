require 'rspec/expectations'
require 'viauco/i18n'
require 'viauco/testing_support/i18n'

describe 'i18n' do
  before do
    I18n.backend.store_translations(:en,
                                                                          viauco: {
                                                                            foo: 'bar',
                                                                            bar: {
                                                                              foo: 'bar within bar scope',
                                                                              invalid: nil,
                                                                              legacy_translation: 'back in the day...'
                                                                            },
                                                                            invalid: nil,
                                                                            legacy_translation: 'back in the day...'
                                                                          })
  end

  it 'translates within the viauco scope' do
    expect(Viauco.normal_t(:foo)).to eql('bar')
    expect(Viauco.translate(:foo)).to eql('bar')
  end

  it 'translates within the viauco scope using a path' do
    allow(Viauco).to receive(:virtual_path).and_return('bar')

    expect(Viauco.normal_t('.legacy_translation')).to eql('back in the day...')
    expect(Viauco.translate('.legacy_translation')).to eql('back in the day...')
  end

  it 'raise error without any context when using a path' do
    expect do
      Viauco.normal_t('.legacy_translation')
    end.to raise_error(StandardError)

    expect do
      Viauco.translate('.legacy_translation')
    end.to raise_error(StandardError)
  end

  it 'prepends a string scope' do
    expect(Viauco.normal_t(:foo, scope: 'bar')).to eql('bar within bar scope')
  end

  it 'prepends to an array scope' do
    expect(Viauco.normal_t(:foo, scope: ['bar'])).to eql('bar within bar scope')
  end

  it 'returns two translations' do
    expect(Viauco.normal_t([:foo, 'bar.foo'])).to eql(['bar', 'bar within bar scope'])
  end

  it 'returns reasonable string for missing translations' do
    expect(Viauco.t(:missing_entry)).to include('<span')
  end

  context 'missed + unused translations' do
    def key_with_locale(key)
      "#{key} (#{I18n.locale})"
    end

    before do
      Viauco.used_translations = []
    end

    context 'missed translations' do
      def assert_missing_translation(key)
        key = key_with_locale(key)
        message = Viauco.missing_translation_messages.detect { |m| m == key }
        expect(message).not_to(be_nil, "expected '#{key}' to be missing, but it wasn't.")
      end

      it 'logs missing translations' do
        Viauco.t(:missing, scope: [:else, :where])
        Viauco.check_missing_translations
        assert_missing_translation('else')
        assert_missing_translation('else.where')
        assert_missing_translation('else.where.missing')
      end

      it 'does not log present translations' do
        Viauco.t(:foo)
        Viauco.check_missing_translations
        expect(Viauco.missing_translation_messages).to be_empty
      end

      it 'does not break when asked for multiple translations' do
        Viauco.t [:foo, 'bar.foo']
        Viauco.check_missing_translations
        expect(Viauco.missing_translation_messages).to be_empty
      end
    end

    context 'unused translations' do
      def assert_unused_translation(key)
        key = key_with_locale(key)
        message = Viauco.unused_translation_messages.detect { |m| m == key }
        expect(message).not_to(be_nil, "expected '#{key}' to be unused, but it was used.")
      end

      def assert_used_translation(key)
        key = key_with_locale(key)
        message = Viauco.unused_translation_messages.detect { |m| m == key }
        expect(message).to(be_nil, "expected '#{key}' to be used, but it wasn't.")
      end

      it "logs translations that aren't used" do
        Viauco.check_unused_translations
        assert_unused_translation('bar.legacy_translation')
        assert_unused_translation('legacy_translation')
      end

      it 'does not log used translations' do
        Viauco.t(:foo)
        Viauco.check_unused_translations
        assert_used_translation('foo')
      end
    end
  end
end

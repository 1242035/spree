require 'spec_helper'
require 'viauco/core/product_filters'

describe 'product filters', type: :model do
  # Regression test for #1709
  context 'finds products filtered by brand' do
    let(:product) { create(:product) }

    before do
      Viauco::Property.create!(name: 'brand', presentation: 'brand')
      product.set_property('brand', 'Nike')
    end

    it 'does not attempt to call value method on Arel::Table' do
      expect { Viauco::Core::ProductFilters.brand_filter }.not_to raise_error
    end

    it "can find products in the 'Nike' brand" do
      expect(Viauco::Product.brand_any('Nike')).to include(product)
    end
    it 'sorts products without brand specified' do
      product.set_property('brand', 'Nike')
      create(:product).set_property('brand', nil)
      expect { Viauco::Core::ProductFilters.brand_filter[:labels] }.not_to raise_error
    end
  end
end

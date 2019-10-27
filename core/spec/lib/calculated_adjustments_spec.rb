require 'spec_helper'

describe Viauco::CalculatedAdjustments do
  it 'adds has_one :calculator relationship' do
    assert Viauco::ShippingMethod.reflect_on_all_associations(:has_one).map(&:name).include?(:calculator)
  end
end

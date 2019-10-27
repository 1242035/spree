require 'spec_helper'

class MyNewSerializer
  include FastJsonapi::ObjectSerializer

  attributes :total
end

class MyCustomCreateService
end

describe Viauco::ApiDependencies, type: :model do
  let (:deps) { Viauco::ApiDependencies.new }

  it 'returns the default value' do
    expect(deps.storefront_cart_serializer).to eq('Viauco::V2::Storefront::CartSerializer')
  end

  it 'allows to overwrite the value' do
    deps.storefront_cart_serializer = MyNewSerializer
    expect(deps.storefront_cart_serializer).to eq MyNewSerializer
  end

  it 'respects global dependecies' do
    Viauco::Dependencies.cart_create_service = MyCustomCreateService
    expect(deps.storefront_cart_create_service).to eq(MyCustomCreateService)
  end
end

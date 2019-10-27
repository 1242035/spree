require 'spec_helper'

class MyCustomCreateService
end

describe Viauco::AppDependencies, type: :model do
  let (:deps) { Viauco::AppDependencies.new }

  it 'returns the default value' do
    expect(deps.cart_create_service).to eq('Viauco::Cart::Create')
  end

  it 'allows to overwrite the value' do
    deps.cart_create_service = MyCustomCreateService
    expect(deps.cart_create_service).to eq MyCustomCreateService
  end
end

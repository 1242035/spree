require 'spec_helper'
require 'cancan/matchers'
require 'viauco/testing_support/ability_helpers'
require 'viauco/testing_support/bar_ability'

# Fake ability for testing registration of additional abilities
class FooAbility
  include CanCan::Ability

  def initialize(_user)
    # allow anyone to perform index on Order
    can :index, Viauco::Order
    # allow anyone to update an Order with id of 1
    can :update, Viauco::Order do |order|
      order.id == 1
    end
  end
end

describe Viauco::Ability, type: :model do
  let(:user) { build(:user) }
  let(:ability) { Viauco::Ability.new(user) }
  let(:token) { nil }

  after do
    Viauco::Ability.abilities = Set.new
  end

  context 'register_ability' do
    it 'adds the ability to the list of abilties' do
      Viauco::Ability.register_ability(FooAbility)
      expect(Viauco::Ability.new(user).abilities).not_to be_empty
    end

    it 'applies the registered abilities permissions' do
      Viauco::Ability.register_ability(FooAbility)
      expect(Viauco::Ability.new(user).can?(:update, mock_model(Viauco::Order, id: 1))).to be true
    end
  end

  context '#abilities_to_register' do
    it 'adds the ability to the list of abilities' do
      allow_any_instance_of(Viauco::Ability).to receive(:abilities_to_register).and_return([FooAbility])
      expect(Viauco::Ability.new(user).abilities).to include FooAbility
    end

    it 'applies the registered abilities permissions' do
      allow_any_instance_of(Viauco::Ability).to receive(:abilities_to_register).and_return([FooAbility])
      expect(Viauco::Ability.new(user).can?(:update, mock_model(Viauco::Order, id: 1))).to be true
    end
  end

  context 'for general resource' do
    let(:resource) { Object.new }

    context 'with admin user' do
      before { allow(user).to receive(:has_viauco_role?).and_return(true) }

      it_behaves_like 'access granted'
      it_behaves_like 'index allowed'
    end

    context 'with customer' do
      it_behaves_like 'access denied'
      it_behaves_like 'no index allowed'
    end
  end

  context 'for admin protected resources' do
    let(:resource) { Object.new }
    let(:resource_shipment) { Viauco::Shipment.new }
    let(:resource_product) { Viauco::Product.new }
    let(:resource_user) { create :user }
    let(:resource_order) { Viauco::Order.new }
    let(:fakedispatch_user) { Viauco.user_class.create }
    let(:fakedispatch_ability) { Viauco::Ability.new(fakedispatch_user) }

    context 'with admin user' do
      it 'is able to admin' do
        user.viauco_roles << Viauco::Role.find_or_create_by(name: 'admin')
        expect(ability).to be_able_to :admin, resource
        expect(ability).to be_able_to :index, resource_order
        expect(ability).to be_able_to :show, resource_product
        expect(ability).to be_able_to :create, resource_user
      end
    end

    context 'with fakedispatch user' do
      it 'is able to admin on the order and shipment pages' do
        user.viauco_roles << Viauco::Role.find_or_create_by(name: 'bar')

        Viauco::Ability.register_ability(BarAbility)

        expect(ability).not_to be_able_to :admin, resource

        expect(ability).to be_able_to :admin, resource_order
        expect(ability).to be_able_to :index, resource_order
        expect(ability).not_to be_able_to :update, resource_order
        # ability.should_not be_able_to :create, resource_order # Fails

        expect(ability).to be_able_to :admin, resource_shipment
        expect(ability).to be_able_to :index, resource_shipment
        expect(ability).to be_able_to :create, resource_shipment

        expect(ability).not_to be_able_to :admin, resource_product
        expect(ability).not_to be_able_to :update, resource_product
        # ability.should_not be_able_to :show, resource_product # Fails

        expect(ability).not_to be_able_to :admin, resource_user
        expect(ability).not_to be_able_to :update, resource_user
        expect(ability).to be_able_to :update, user
        # ability.should_not be_able_to :create, resource_user # Fails
        # It can create new users if is has access to the :admin, User!!
        expect(ability).to be_able_to :create, user

        # TODO: change the Ability class so only users and customers get the extra premissions?

        Viauco::Ability.remove_ability(BarAbility)
      end
    end

    context 'with customer' do
      it 'is not able to admin' do
        expect(ability).not_to be_able_to :admin, resource
        expect(ability).not_to be_able_to :admin, resource_order
        expect(ability).not_to be_able_to :admin, resource_product
        expect(ability).not_to be_able_to :admin, resource_user
      end
    end
  end

  context 'as Guest User' do
    context 'for Country' do
      let(:resource) { Viauco::Country.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for OptionType' do
      let(:resource) { Viauco::OptionType.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for OptionValue' do
      let(:resource) { Viauco::OptionType.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for Order' do
      let(:resource) { Viauco::Order.new }

      context 'requested by same user' do
        before { resource.user = user }

        it_behaves_like 'access granted'
        it_behaves_like 'no index allowed'
      end

      context 'requested by other user' do
        before { resource.user = Viauco.user_class.new }

        it_behaves_like 'create only'
      end

      context 'requested with proper token' do
        let(:token) { 'TOKEN123' }

        before { allow(resource).to receive_messages token: token }

        it_behaves_like 'access granted'
        it_behaves_like 'no index allowed'
      end

      context 'requested with inproper token' do
        let(:token) { 'FAIL' }

        before { allow(resource).to receive_messages token: token }

        it_behaves_like 'create only'
      end
    end

    context 'for Product' do
      let(:resource) { Viauco::Product.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for ProductProperty' do
      let(:resource) { Viauco::Product.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for Property' do
      let(:resource) { Viauco::Product.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for State' do
      let(:resource) { Viauco::State.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for Taxons' do
      let(:resource) { Viauco::Taxon.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for Taxonomy' do
      let(:resource) { Viauco::Taxonomy.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for User' do
      context 'requested by same user' do
        let(:resource) { user }

        it_behaves_like 'access granted'
        it_behaves_like 'no index allowed'
      end

      context 'requested by other user' do
        let(:resource) { create(:user) }

        it_behaves_like 'create only'
      end
    end

    context 'for Variant' do
      let(:resource) { Viauco::Variant.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end

    context 'for Zone' do
      let(:resource) { Viauco::Zone.new }

      context 'requested by any user' do
        it_behaves_like 'read only'
      end
    end
  end
end

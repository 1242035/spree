# Fake ability for testing administration
class BarAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Viauco::User.new
    if user.has_viauco_role? 'bar'
      # allow dispatch to :admin, :index, and :show on Viauco::Order
      can [:admin, :index, :show], Viauco::Order
      # allow dispatch to :index, :show, :create and :update shipments on the admin
      can [:admin, :manage], Viauco::Shipment
    end
  end
end

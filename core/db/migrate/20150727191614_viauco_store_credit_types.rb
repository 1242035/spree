class ViaucoStoreCreditTypes < ActiveRecord::Migration[4.2]
  def up
    Viauco::StoreCreditType.find_or_create_by(name: 'Expiring', priority: 1)
    Viauco::StoreCreditType.find_or_create_by(name: 'Non-expiring', priority: 2)
  end

  def down
    Viauco::StoreCreditType.find_by(name: 'Expiring').try(&:destroy)
    Viauco::StoreCreditType.find_by(name: 'Non-expiring').try(&:destroy)
  end
end

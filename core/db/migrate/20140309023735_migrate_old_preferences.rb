class MigrateOldPreferences < ActiveRecord::Migration[4.2]
  def up
    if Viauco::Calculator.respond_to?(:with_deleted)
      migrate_preferences(Viauco::Calculator.with_deleted)
    else
      migrate_preferences(Viauco::Calculator)
    end
    migrate_preferences(Viauco::PaymentMethod)
    migrate_preferences(Viauco::PromotionRule)
  end

  def down
  end

  private
  def migrate_preferences klass
    klass.reset_column_information
    klass.find_each do |record|
      store = Viauco::Preferences::ScopedStore.new(record.class.name.underscore, record.id)
      record.defined_preferences.each do |key|
        value = store.fetch(key){}
        record.preferences[key] = value unless value.nil?
      end
      record.save!
    end
  end
end

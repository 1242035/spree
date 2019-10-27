class AddUniqueIndexOnNumberToViaucoReturnAuthorizations < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:viauco_return_authorizations, :number, unique: true)
      numbers = Viauco::ReturnAuthorization.group(:number).having('sum(1) > 1').pluck(:number)
      authorizations = Viauco::ReturnAuthorization.where(number: numbers)

      authorizations.find_each do |authorization|
        authorization.number = authorization.class.number_generator.method(:generate_permalink).call(authorization.class)
        authorization.save
      end

      remove_index :viauco_return_authorizations, :number if index_exists?(:viauco_return_authorizations, :number)
      add_index :viauco_return_authorizations, :number, unique: true
    end
  end
end

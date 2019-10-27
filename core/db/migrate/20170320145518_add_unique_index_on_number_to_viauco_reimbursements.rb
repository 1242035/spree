class AddUniqueIndexOnNumberToViaucoReimbursements < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:viauco_reimbursements, :number, unique: true)
      numbers = Viauco::Reimbursement.group(:number).having('sum(1) > 1').pluck(:number)
      reimbursements = Viauco::Reimbursement.where(number: numbers)

      reimbursements.find_each do |reimbursement|
        reimbursement.number = reimbursement.class.number_generator.method(:generate_permalink).call(reimbursement.class)
        reimbursement.save
      end

      remove_index :viauco_reimbursements, :number if index_exists?(:viauco_reimbursements, :number)
      add_index :viauco_reimbursements, :number, unique: true
    end
  end
end

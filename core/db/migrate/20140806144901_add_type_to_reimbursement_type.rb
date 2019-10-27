class AddTypeToReimbursementType < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_reimbursement_types, :type, :string
    add_index :viauco_reimbursement_types, :type

    Viauco::ReimbursementType.reset_column_information
    Viauco::ReimbursementType.find_by(name: Viauco::ReimbursementType::ORIGINAL).update!(type: 'Viauco::ReimbursementType::OriginalPayment')
  end
end

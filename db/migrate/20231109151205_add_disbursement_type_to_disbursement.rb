class AddDisbursementTypeToDisbursement < ActiveRecord::Migration[7.0]
  def change
    add_column :disbursements, :disbursement_type, :string
  end
end

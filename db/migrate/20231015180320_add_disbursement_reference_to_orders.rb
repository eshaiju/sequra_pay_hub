# frozen_string_literal: true

class AddDisbursementReferenceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :disbursement_reference, :string
    add_reference :orders, :disbursement, foreign_key: true, allow_nil: true
  end
end

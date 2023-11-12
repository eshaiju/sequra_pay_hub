# frozen_string_literal: true

class AddCancellationDisbursementToModel < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :cancellation_disbursement, foreign_key: { to_table: :disbursements }
  end
end

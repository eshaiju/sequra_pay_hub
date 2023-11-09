# frozen_string_literal: true

class AddCancellationDisbursementIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :cancellation_disbursement_id, :integer
  end
end

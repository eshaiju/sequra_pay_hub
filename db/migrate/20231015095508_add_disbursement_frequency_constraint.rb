# frozen_string_literal: true

class AddDisbursementFrequencyConstraint < ActiveRecord::Migration[6.1]
  def up
    add_column :merchants, :disbursement_frequency, :disbursement_frequency, default: 'daily', null: false
  end
end

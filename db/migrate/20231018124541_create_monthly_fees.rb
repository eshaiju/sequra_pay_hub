# frozen_string_literal: true

class CreateMonthlyFees < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_fees do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :total_commissions, null: false, precision: 8, scale: 2
      t.decimal :monthly_fee, null: false, precision: 8, scale: 2
      t.date :month, null: false

      t.timestamps
    end
  end
end

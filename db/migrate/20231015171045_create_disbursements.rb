# frozen_string_literal: true

class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true
      t.string :reference, null: false
      t.date :disbursement_date, null: false
      t.decimal :total_amount, precision: 8, scale: 2, null: false
      t.decimal :total_fee, precision: 8, scale: 2, null: false

      t.timestamps
    end

    add_index :disbursements, :reference, unique: true
  end
end

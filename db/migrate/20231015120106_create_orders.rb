# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :amount
      t.date :order_date

      t.timestamps
    end
  end
end

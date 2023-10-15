# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :reference, unique: true
      t.string :email
      t.date :live_on
      t.decimal :minimum_monthly_fee

      t.timestamps
    end
  end
end

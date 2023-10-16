# frozen_string_literal: true

class AddUniqueIndexToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_index :merchants, :reference, unique: true
    add_index :merchants, :email, unique: true
  end
end

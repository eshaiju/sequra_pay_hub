# frozen_string_literal: true

class AddDisbursementFrequencyEnumType < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL.squish
      CREATE TYPE disbursement_frequency AS ENUM ('daily', 'weekly');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP TYPE disbursement_frequency;
    SQL
  end
end

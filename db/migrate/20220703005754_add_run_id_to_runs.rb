# frozen_string_literal: true

class AddRunIdToRuns < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :run_id, :string
  end
end

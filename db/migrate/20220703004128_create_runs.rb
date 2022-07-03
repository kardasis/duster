# frozen_string_literal: true

class CreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :runs, id: :uuid do |t|
      t.timestamps
    end
  end
end

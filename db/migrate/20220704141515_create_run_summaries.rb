class CreateRunSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :run_summaries do |t|
      t.uuid :run_id, null: false, foreign_key: true
      t.decimal :total_time, null: false
      t.decimal :total_distance, null: false
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end

class CreateRunSlices < ActiveRecord::Migration[7.0]
  def change
    create_table :run_slices do |t|
      t.integer :run_summary_id, null: false, foreign_key: true

      t.string :nominal_distance

      t.integer :start_index, null: false
      t.integer :end_index, null: false
      t.integer :start_time
      t.integer :end_time
      t.timestamps

      t.index :run_summary_id
    end
  end
end

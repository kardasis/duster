class AddLiveRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :live_runs do |t|
      t.integer :start_tickstamp
      t.integer :last_tick
      t.integer :tick_count, null: false, default: 0
      t.decimal :speed
      t.uuid :run_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end

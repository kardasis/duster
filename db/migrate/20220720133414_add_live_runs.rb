class AddLiveRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :live_runs do |t|
      t.integer :first_tickstamp
      t.integer :last_tickstamp
      t.integer :tick_count, null: false, default: 0
      t.references :run, null: false

      t.timestamps
    end
  end
end

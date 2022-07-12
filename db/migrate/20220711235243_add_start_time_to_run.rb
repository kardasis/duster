class AddStartTimeToRun < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :start_time, :datetime, null: false
  end
end

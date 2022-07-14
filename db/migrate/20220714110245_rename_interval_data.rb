class RenameIntervalData < ActiveRecord::Migration[7.0]
  def change
    rename_column :run_summaries, :speed_data_uri, :interval_data_uri
  end
end

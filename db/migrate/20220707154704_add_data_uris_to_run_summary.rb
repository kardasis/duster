class AddDataUrisToRunSummary < ActiveRecord::Migration[7.0]
  def change
    add_column :run_summaries, :raw_data_uri, :string
    add_column :run_summaries, :speed_data_uri, :string
  end
end

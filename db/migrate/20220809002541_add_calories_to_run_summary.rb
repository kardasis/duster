class AddCaloriesToRunSummary < ActiveRecord::Migration[7.0]
  def change
    add_column :run_summaries, :calories, :decimal
  end
end

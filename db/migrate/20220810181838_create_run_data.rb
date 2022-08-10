class CreateRunData < ActiveRecord::Migration[7.0]
  class Run < ApplicationRecord
    has_one :run_data
  end

  class RunData < ApplicationRecord
    belongs_to :run
  end

  def up
    create_run_data_table

    RunSummary.find_each do |rs|
      if rs.raw_data_uri.split('/').last == rs.run.id
        RunData.create raw_data_uri: rs.raw_data_uri, interval_data_uri: rs.interval_data_uri, run_id: rs.run.id
      end
    end

    remove_summary_columns
  end

  def down
    drop_table :run_data

    add_column :run_summaries, :raw_data_uri, :string
    add_column :run_summaries, :interval_data_uri, :string
  end
end

def create_run_data_table
  create_table :run_data do |t|
    t.uuid :run_id, null: false, foreign_key: true
    t.string :raw_data_uri
    t.string :interval_data_uri

    t.timestamps
  end
end

def remove_summary_columns
  remove_column :run_summaries, :raw_data_uri
  remove_column :run_summaries, :interval_data_uri
end

class AddFirstTickstampToRun < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :first_tickstamp, :integer
  end
end

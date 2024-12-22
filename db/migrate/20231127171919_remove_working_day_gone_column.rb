class RemoveWorkingDayGoneColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :working_days, :day_gone
  end
end

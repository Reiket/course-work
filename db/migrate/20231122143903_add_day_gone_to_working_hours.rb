class AddDayGoneToWorkingHours < ActiveRecord::Migration[7.0]
  def change
    add_column :working_hours, :hour_gone, :boolean, default: false
    add_column :working_days, :day_gone, :boolean, default: false
  end
end

class ChangeTypeHourInTableHours < ActiveRecord::Migration[7.0]
  def up
    remove_column :working_hours, :hour
    add_column :working_hours, :hour, :datetime
  end

  def down
    remove_column :working_hours, :hour
    add_column :working_hours, :hour, :time
  end
end

class AddWorkingHourToAppoinment < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :working_hour
  end
end

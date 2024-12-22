class CreateWorkingHours < ActiveRecord::Migration[7.0]
  def change
    create_table :working_hours do |t|
      t.time :hour
      t.integer :status, default: 0
      t.references :working_day, foreign_key: true

      t.timestamps
    end
  end
end

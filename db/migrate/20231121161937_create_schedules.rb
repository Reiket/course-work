class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :doctor, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

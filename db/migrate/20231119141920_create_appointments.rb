class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :doctor, foreign_key: true
      t.references :patient, foreign_key: true
      t.date :date
      t.time :time
      t.integer :status

      t.timestamps
    end
  end
end

class CreateWorkingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :working_days do |t|
      t.string  :name
      t.integer :status, default: 0
      t.integer :priority
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end

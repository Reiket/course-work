class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :surname
      t.string :photo
      t.string :phone_number
      t.string :position
      t.integer :experience
      t.integer :satisfied_patients_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

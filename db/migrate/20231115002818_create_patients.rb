class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :surname
      t.string :photo
      t.datetime :birthday
      t.string :residence
      t.string :phone_number
      t.integer :gender
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

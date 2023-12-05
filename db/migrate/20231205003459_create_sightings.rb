class CreateSightings < ActiveRecord::Migration[7.0]
  def change
    create_table :sightings do |t|
      t.belongs_to :titan, null: false, foreign_key: true
      t.date :first_sight
      t.date :last_sight

      t.timestamps
    end
  end
end

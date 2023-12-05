class CreateDeaths < ActiveRecord::Migration[7.0]
  def change
    create_table :deaths do |t|
      t.belongs_to :titan, null: false, foreign_key: true
      t.text :cause
      t.date :date

      t.timestamps
    end
  end
end

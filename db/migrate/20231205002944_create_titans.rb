class CreateTitans < ActiveRecord::Migration[7.0]
  def change
    create_table :titans do |t|
      t.string :alias
      t.integer :height

      t.timestamps
    end
  end
end

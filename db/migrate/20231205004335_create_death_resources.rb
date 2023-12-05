class CreateDeathResources < ActiveRecord::Migration[7.0]
  def change
    create_join_table :deaths, :resources
  end
end

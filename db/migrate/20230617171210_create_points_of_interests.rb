class CreatePointsOfInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :points_of_interests do |t|
      t.references :hike, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :step
      t.text :description

      t.timestamps
    end
  end
end

class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.references :hike, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

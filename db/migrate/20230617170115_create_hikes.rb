class CreateHikes < ActiveRecord::Migration[7.0]
  def change
    create_table :hikes do |t|
      t.string :name
      t.text :description
      t.float :time
      t.float :distance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

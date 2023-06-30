class AddCityToHike < ActiveRecord::Migration[7.0]
  def change
    add_column :hikes, :city, :string
  end
end

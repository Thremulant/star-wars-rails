class AddMissingColumnsPlanet < ActiveRecord::Migration[6.1]
  def change
    add_column :planets, :climate, :string
    add_column :planets, :diameter, :string
    add_column :planets, :gravity, :integer
    add_column :planets, :orbital_period, :integer
    add_column :planets, :population, :integer
    add_column :planets, :rotation_period, :integer
    add_column :planets, :surface_water, :integer
    add_column :planets, :terrain, :string
    add_column :planets, :url, :string
  end
end

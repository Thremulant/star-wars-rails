class AddPlanetRefToRaces < ActiveRecord::Migration[6.1]
  def change
    add_reference :races, :planet, null: false, foreign_key: true
  end
end

class AddPlanetRefToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :planet, null: false, foreign_key: true
  end
end

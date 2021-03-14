class AddRaceRefToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :race, null: false, foreign_key: true
  end
end

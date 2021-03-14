class AddMissingColumnsCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :birth_year, :string
    add_column :characters, :eye_color, :string
    add_column :characters, :gender, :string
    add_column :characters, :hair_color, :string
    add_column :characters, :height, :string
    add_column :characters, :skin_color, :string
    add_column :characters, :url, :string
  end
end

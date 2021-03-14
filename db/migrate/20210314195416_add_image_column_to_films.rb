class AddImageColumnToFilms < ActiveRecord::Migration[6.1]
  def change
    add_column :films, :image, :string
  end
end

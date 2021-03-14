class AddMissingColumnsFilm < ActiveRecord::Migration[6.1]
  def change
    add_column :films, :opening_crawl, :text
    add_column :films, :producer, :string
    add_column :films, :release_date, :date
    add_column :films, :url, :string
    add_column :films, :episode_id, :integer
    add_column :films, :director, :string
  end
end

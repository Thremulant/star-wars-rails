class AddMissingColumnsRace < ActiveRecord::Migration[6.1]
  def change
    add_column :races, :average_lifespan, :integer
    add_column :races, :classification, :string
    add_column :races, :designation, :string
    add_column :races, :language, :string
    add_column :races, :url, :string
  end
end

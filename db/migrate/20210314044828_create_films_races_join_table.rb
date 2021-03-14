class CreateFilmsRacesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :films, :races
  end
end

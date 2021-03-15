class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @films = @race.films.all
    @characters = @race.characters.all
    @planet = @race.planet
  end
end

class RacesController < ApplicationController
  def index
    @q = Race.where.not(name: 'Unknown').ransack(params[:q])
    @pagy, @races = pagy(@q.result, items: 10)
  end

  def show
    @race = Race.find(params[:id])
    @films = @race.films.all
    @characters = @race.characters.all
    @planet = @race.planet
  end
end

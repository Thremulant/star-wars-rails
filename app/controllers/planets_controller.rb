class PlanetsController < ApplicationController
  def index
    @q = Planet.where.not(name: 'Unknown').ransack(params[:q])
    @pagy, @planets = pagy(@q.result, items: 10)
  end

  def show
    @planet = Planet.find(params[:id])
    @films = @planet.films.all
    @races = @planet.races
    @characters = @planet.characters.all
  end
end

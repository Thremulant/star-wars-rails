class PlanetsController < ApplicationController
  def index
    @planets = Planet.all
  end

  def show
    @planet = Planet.find(params[:id])
    @films = @planet.films.all
    @races = @planet.races
    @characters = @planet.characters.all
  end
end

class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
    @characters = @film.characters.all
    @races = @film.races.all
    @planets = @film.planets.all
  end

end

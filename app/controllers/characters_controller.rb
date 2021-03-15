class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
    @films = @character.films.all
    @race = @character.race
    @planet = @character.planet
  end
end

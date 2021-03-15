class CharactersController < ApplicationController
  def index
    @q = Character.ransack(params[:q])
    @pagy, @characters = pagy(@q.result, items: 10)
  end

  def show
    @character = Character.find(params[:id])
    @films = @character.films.all
    @race = @character.race
    @planet = @character.planet
  end
end

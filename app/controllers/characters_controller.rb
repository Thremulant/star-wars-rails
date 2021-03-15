class CharactersController < ApplicationController
  def index
    # @characters = Character.paginate(page: params[:page], per_page: 10)
    # @characters_pagination = Character.paginate(page: params[:page], per_page: 10, conditions: ['name like ?', "%#{params[:search]}%"])
    # @all_characters = Character.where('name like ?', params[:search]).order('name')
    @characters = Character.all
    @characters = Character.where('name like ?', params[:search]).order('name').page(params[:page]).per_page(10)
  end

  def show
    @character = Character.find(params[:id])
    @films = @character.films.all
    @race = @character.race
    @planet = @character.planet
  end
end

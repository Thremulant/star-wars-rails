class FilmsController < ApplicationController
  def index
    @films = Film.all
  end
end

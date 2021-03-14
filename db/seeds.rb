# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'
require 'pp'

Film.destroy_all
Character.destroy_all
Planet.destroy_all
Race.destroy_all

def get_data_url(url)
  uri = URI(url)
  res = Net::HTTP.get(uri)
  json_res = JSON.parse(res)
end

def main_data_retrieval()

  films_url = 'https://swapi.dev/api/films/'
  all_films = get_data_url(films_url)
  # pp all_films['results'][0]

  all_films['results'].each do |single_movie|
    film_created = Film.find_or_create_by(
      title: single_movie['title'],
      episode_id: single_movie['episode_id'],
      opening_crawl: single_movie['opening_crawl'],
      director: single_movie['director'],
      producer: single_movie['producer'],
      release_date: single_movie['release_date'],
      url: single_movie['url']
    )

    puts single_movie['title']

    # PLANETS
    single_movie['planets'].each do |single_planet|
      # Convert to HTTPS that works fine
      single_planet.sub! 'http', 'https'

      # Retrieve all planets assocciated with the film
      api_planet = get_data_url(single_planet)
      api_planet_url = api_planet['url'].sub! 'http', 'https'

      # Create object
      planet_create = film_created.planets.find_or_create_by(
        name: api_planet['name'],
        climate: api_planet['climate'],
        diameter: api_planet['diameter'],
        gravity: api_planet['gravity'],
        orbital_period: api_planet['orbital_period'],
        population: api_planet['population'],
        rotation_period: api_planet['rotation_period'],
        surface_water: api_planet['surface_water'],
        terrain: api_planet['terrain'],
        url: api_planet_url
      )
    end

    # single_movie['characters'].each do |single_character|
    #   # Convert to HTTPS that works fine
    #   single_character.sub! 'http', 'https'

    #   # Retrieve all characters assocciated with the film
    #   api_characters = get_data_url(single_character)
    #   api_characters_url = api_characters['url'].sub! 'http', 'https'

    #   # Create the objects
    #   character_create = film_created.characters.find_or_create_by(
    #     name: api_characters['name'],
    #     birth_year: api_characters['birth_year'],
    #     eye_color: api_characters['eye_color'],
    #     gender: api_characters['gender'],
    #     hair_color: api_characters['hair_color'],
    #     height: api_characters['height'],
    #     skin_color: api_characters['skin_color'],
    #     url: api_characters_url
    #   )
    # end



    # pp single_movie
    # Find.find_or_create_by
    # puts single_movie['title']
  end
end

# ------MAIN DATA RETRIEVAL-----
# main_data_retrieval()


# ------TESTS-----
first_film = Film.create(title: "Firt film")
new_planet = first_film.planets.create(name:'jupiter')
new_race = first_film.races.create(name:'titor', planet:new_planet)
new_char = first_film.characters.create(name:'luke', race:new_race, planet:new_planet)
puts new_char.errors.messages.inspect

# puts new_planet.characters.first.name

# first_film = Film.create(title: "Firt film")

# puts "--FILMS--"
# Film.all.each do |t|
#   puts t.title
# end

# first_char = Character.create(name: 'Luke')
# new_char = first_film.characters.create(name: 'Leia')

# puts "--CHARACTERS--"
# Character.all.each do |t|
#   puts t.name
# end

# first_planet = Planet.create(name: "Jupiter")
# new_planet = first_film.planets.create(name: "Saturn")

# # puts new_planet.name
# puts "--PLANETS--"
# Planet.all.each do |t|
#   puts t.name
# end

# first_specie = first_planet.species.create(name:"Human")

# puts first_specie.errors.messages.inspect

# puts "--SPECIE--"
# Species.all.each do |t|
#   puts t.name
# end

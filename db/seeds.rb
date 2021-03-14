require 'net/http'
require 'json'
require 'pp'

def destroy_everything
  Film.destroy_all
  Character.destroy_all
  Planet.destroy_all
  Race.destroy_all

  empty_planet = Planet.create(name:'Unknown')
  empty_race = Race.create(name:'Unknown', planet:empty_planet)

end

def replace_to_htmls(convert)
  convert.sub! 'http', 'https' unless convert.include? 'https'
  convert
end

def get_data_url(url)
  uri = URI(url)
  res = Net::HTTP.get(uri)
  json_res = JSON.parse(res)
end

def retrieve_films_and_planets
  films_url = 'https://swapi.dev/api/films/'
  all_films = get_data_url(films_url)

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

    # ADD ALL PLANETS ASSOCCIATED WITH A MOVIE
    single_movie['planets'].each do |single_planet|
      # Convert to HTTPS that works fine
      single_planet.sub! 'http', 'https'

      # Retrieve all planets assocciated with the film
      api_planet = get_data_url(single_planet)
      api_planet_url = api_planet['url'].sub! 'http', 'https'

      # Create object
      find_initial_planet = Planet.where(name: api_planet['name'])
      if find_initial_planet.length == 0
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
      else
        film_created.planets << find_initial_planet
      end

    end

    single_movie['species'].each do |single_race|
      # Convert to HTTPS that works fine
      single_race.sub! 'http', 'https'

      # Retrieve all races assocciated with the film
      api_races = get_data_url(single_race)
      api_races_url = api_races['url'].sub! 'http', 'https'

      # #retrieve the planet from teh API and match it to the DB
      race_planet = Planet.new
      if api_races['homeworld'].present?
        race_planet_url = api_races['homeworld'].sub! 'http', 'https'
        race_planet_data = get_data_url(race_planet_url)
        race_planet_data_url = race_planet_data['url'].sub! 'http', 'https'
        race_planet = Planet.find_or_create_by(
          name: race_planet_data['name'],
          climate: race_planet_data['climate'],
          diameter: race_planet_data['diameter'],
          gravity: race_planet_data['gravity'],
          orbital_period: race_planet_data['orbital_period'],
          population: race_planet_data['population'],
          rotation_period: race_planet_data['rotation_period'],
          surface_water: race_planet_data['surface_water'],
          terrain: race_planet_data['terrain'],
          url: race_planet_data_url
        )
      else
        race_planet = Planet.where(name: 'Unknown')[0]

      end

      find_initial_race = Race.where(name: api_races['name'])
      if find_initial_race.length == 0
        race_create = film_created.races.find_or_create_by(
          name: api_races['name'],
          average_lifespan: api_races['average_lifespan'],
          classification: api_races['classification'],
          designation: api_races['designation'],
          language: api_races['language'],
          url: api_races_url,
          planet: race_planet
          )
      else
        film_created.races << find_initial_race
      end

    end

    # RETRIEVE ALL CHARACTERS
    single_movie['characters'].each do |single_character|
      # Convert to HTTPS that works fine
      single_character.sub! 'http', 'https'

      # Retrieve all characters assocciated with the film
      api_characters = get_data_url(single_character)
      api_characters_url = replace_to_htmls(api_characters['url'])

      # retrieve the CHARACTER'S PLANET from the API and match it to the DB
      character_planet = Planet.new
      if api_characters['homeworld'].present?
        character_planet_url = replace_to_htmls(api_characters['homeworld'])
        character_planet_data = get_data_url(character_planet_url)
        character_planet_data_url = replace_to_htmls(character_planet_data['url'])

        find_planet = Planet.where(name: character_planet_data['name'])
        if find_planet.length == 0
          character_planet = Planet.find_or_create_by(
            name: character_planet_data['name'],
            climate: character_planet_data['climate'],
            diameter: character_planet_data['diameter'],
            gravity: character_planet_data['gravity'],
            orbital_period: character_planet_data['orbital_period'],
            population: character_planet_data['population'],
            rotation_period: character_planet_data['rotation_period'],
            surface_water: character_planet_data['surface_water'],
            terrain: character_planet_data['terrain'],
            url: character_planet_data_url
          )
        else
          character_planet = find_planet[0]
        end
      else
        character_planet = Planet.where(name: 'Unknown')[0]
      end


      # retrieve the CHARACTERS RACE from the API and match it to the DB
      if api_characters['species'].length != 0

        character_race_planet = Planet.new
        character_race = Race.new

        character_race_url = replace_to_htmls(api_characters['species'][0])
        character_race_data = get_data_url(character_race_url)
        character_race_data_url = replace_to_htmls(character_race_data['url'])

        if !character_race_data['homeworld'].present?
          character_race_planet = Planet.where(name: 'Unknown')[0]
        else
          character_race_planet_api = get_data_url(replace_to_htmls(character_race_data['homeworld']))
          if character_race_planet_api['homeworld'].present?
            new_race_planet_url = replace_to_htmls(character_race_planet_api['homeworld'])
            new_race_planet_data = get_data_url(new_race_planet_url)
            new_race_planet_data_url = replace_to_htmls(new_race_planet_data['url'])
            find_race_planet = Planet.where(name:  new_race_planet_data['name'])
            if find_race_planet.length == 0
              character_race_planet = Planet.find_or_create_by(
                name: new_race_planet_data['name'],
                climate: new_race_planet_data['climate'],
                diameter: new_race_planet_data['diameter'],
                gravity: new_race_planet_data['gravity'],
                orbital_period: new_race_planet_data['orbital_period'],
                population: new_race_planet_data['population'],
                rotation_period: new_race_planet_data['rotation_period'],
                surface_water: new_race_planet_data['surface_water'],
                terrain: new_race_planet_data['terrain'],
                url: new_race_planet_data_url
              )
            else
              character_race_planet = find_race_planet[0]
            end
          else
            character_race_planet = Planet.where(name: 'Unknown')[0]
          end
        end

        find_race = Race.where(name: character_race_data['name'])
        if find_race.length == 0
          character_race = Race.find_or_create_by(
            name: character_race_data['name'],
            average_lifespan: character_race_data['average_lifespan'],
            classification: character_race_data['classification'],
            designation: character_race_data['designation'],
            language: character_race_data['language'],
            url: character_race_data_url,
            planet: character_race_planet
          )
        else
          character_race = find_race[0]
        end
      else
        character_race = Race.where(name: 'Unknown')[0]
      end

        find_character = Character.where(name: api_characters['name'])
        if find_character.length == 0
          character_create = film_created.characters.find_or_create_by(
                  name: api_characters['name'],
                  birth_year: api_characters['birth_year'],
                  eye_color: api_characters['eye_color'],
                  gender: api_characters['gender'],
                  hair_color: api_characters['hair_color'],
                  height: api_characters['height'],
                  skin_color: api_characters['skin_color'],
                  url: api_characters_url,
                  planet: character_planet,
                  race: character_race
                )
        else
          # puts find_character[0]
          film_created.characters << find_character
        end
      end
    puts single_movie['title'] + ' DONE'
  end
end

# ------MAIN DATA RETRIEVAL-----
destroy_everything
retrieve_films_and_planets

# ------TESTS-----
# first_film = Film.create(title: "Firt film")
# new_planet = first_film.planets.create(name:'jupiter')
# new_race = first_film.races.create(name:'titor', planet:new_planet)
# new_char = first_film.characters.create(name:'luke', race:new_race, planet:new_planet)
# puts new_char.errors.messages.inspect

# puts new_planet.characters.first.name

# Star Wars on Rails

## Datasets description
I wanted to use the Star Wars API - [SWAPI](https://swapi.dev/) to build a small application that can navigate through some of the contents.

The problem was that their gem doesn't work. So, I needed to import the data using HTTP requests and parsing it to JSON.
It took some time, but the DB is being populated by crawling from Films into Planets, then into Species and finally into Characters.

- Films: Main component, as they include all of the other ones. Important to notice, is that the relationship with the others are many-to-many.
- Planets: They don't require any Specie or Character to exist in order for the planet to exist.
- Species: They  require a planet minimum to exist, and will have multiple Characters assocciated.
- Characters: Multiple assocciation to Films, and will have FK for Planets and Species.

Additionally, I wanted to add some images. But there are no APIs that hold the images for the characters, planets or species. And I didn't have enough time to download all the images.
Even so I found that I could use [IMDB's API](https://v2.sg.media-imdb.com/suggests/) to get the movies and the posters. That's what's being use to pull those images.

## ERD
[![star-wars-erd.jpg](https://i.postimg.cc/MZM8RdCG/star-wars-erd.jpg)](https://postimg.cc/6TXSxL5s)


## Sidenote
The SEED file, is probably the WORST code I've made so far. It can be improved with refactoring with methods for creation and verification of the content that already exist.
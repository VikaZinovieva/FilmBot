require 'json'
require 'date'

class FilmListAnalyzer
  FILE_FILMS = 'films.json'

  def format_list_films(type_film)
    all_films = list_of_films(type_film)
    all_films.map{ |film| format_string(film) }.join('')
  end

  def random_film(type_film)
    film = list_of_films(type_film).to_a.sample
    format_string(film)
  end

  private

  def list_of_films(type_film)
    JSON.parse(File.read(FILE_FILMS))[type_film]
  end

  def format_string(film)
    "Name film: #{film.first} Year: #{film.last}\n"
  end
end

# print FileAnalyzer.new.find_films("detectives")
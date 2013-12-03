require_relative "lib/movie"
require_relative "lib/api"

movies_added = []

def find_movie (movies_added)

  puts "Add a movie you really like: "
  movie_title = gets

  if movie_title == "\n"
    puts "Please enter a valid title: "
    find_movie
  end

  movie = Api.search_by_title(movie_title)

  if movie
    puts "\nFound:\n"
    puts "Title -> #{movie.title}"
    puts "Score -> #{movie.score}"
    puts "Year -> #{movie.year}"

    movies_added << movie

  else
    puts "Sorry no movie was found"
  end

end

def calculateAverageRatings (movies_added, year)
  score,totalScores,count = 0,0,0

  for movie in movies_added
    if year && movie.year == year
      score = movie.score
      totalScores += score
      count += 1
    elsif !year
      score = movie.score
      totalScores += score
      count += 1
    end
  end

  avg = totalScores/count

  return avg
  
end

def findFirstandLastYear (movies_added)
   min_year, max_year = movies_added.first.year, movies_added.first.year

   for movie in movies_added
    currentMovieYear = movie.year
    if currentMovieYear < min_year
      min_year = currentMovieYear
    elsif currentMovieYear > max_year
      max_year = currentMovieYear
    end

    return min_year, max_year
end

def slope (movies_added)

  first_year, last_year = findFirstandLastYear(movies_added)
  first_year_avg = calculateAverageRatings(movies_added, first_year)
  last_year_avg = calculateAverageRatings(movies_added, last_year)

  slope = (last_year_avg - first_year_avg).to_f / (last_year - first_year).to_f

  if slope >= 0
    return "Happier"
  else 
    return "Madder"
  end
  
end

find_movie (movies_added)

while true do
  puts "\nThe movie list average rattings is #{calculateAverageRatings(movies_added,nil)}"
  puts "\nYou are getting #{slope(movies_added)}"
  puts "\nSearch Again (Y/N)" 
  answer = gets.upcase[0]
  
  if answer == "Y"
    find_movie(movies_added)
  else 
    break
  end
end
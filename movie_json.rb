require_relative "lib/movie"
require_relative "lib/api"

movies_added = Array.new

def find_movie
  puts "Add a movie you really like"
  movie_title = gets
  if movie_title == "\n"
    puts "Please enter a title"
    find_movie
  end
  movie = Api.search_by_title(movie_title)
  if movie
    #puts "Found: #{movie.title}. Score: #{movie.score}"
    puts "\nFound:\n"
    puts "Title -> #{movie.title}"
    puts "Score -> #{movie.score}"
    puts "Year -> #{movie.year}"
    movies_added << movie
    count = 0 
    totalScores = 0
    for moviefound in movies_added
      score = moviefound.score
      totalScores += score
      count++
    end
    avg = totalScores/count

    puts "\n\nAverge Rattings of all movies added = #{avg}"
    
  else
    puts "Sorry No Movie with that Title Was Found."
  end
    
end

find_movie

while true do
  puts "Search Again (Y/N)" 
  answer = gets.upcase[0]
  if answer == "Y"
    find_movie
  else
    break
  end
end

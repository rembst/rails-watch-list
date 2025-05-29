# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)['results']

puts "Creating movies..."

movies.first(10).each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}",
    rating: movie['vote_average'],
  )

end

puts "Creating lists..."

list1 = List.create!(name: "Top 10")
list2 = List.create!(name: "Crime & Drama")

puts "Creating bookmarks..."

Bookmark.create!(
  comment: "Un chef-d'œuvre !",
  movie: Movie.find_by(title: "The Shawshank Redemption"),
  list: list1
)

Bookmark.create!(
  comment: "Le parrain de tous les films.",
  movie: Movie.find_by(title: "The Godfather"),
  list: list2
)

puts "Seeding finished ✅"

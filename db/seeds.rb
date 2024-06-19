# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
Movie.destroy_all
Review.destroy_all

# Create movies
movies = [
  {
    title: "The Shawshank Redemption",
    description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
    release_date: "1994-09-23",
    director: "Frank Darabont",
    rating: 9
  },
  {
    title: "The Godfather",
    description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
    release_date: "1972-03-24",
    director: "Francis Ford Coppola",
    rating: 9
  },
  {
    title: "The Dark Knight",
    description: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
    release_date: "2008-07-18",
    director: "Christopher Nolan",
    rating: 9
  },
  {
    title: "Pulp Fiction",
    description: "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
    release_date: "1994-10-14",
    director: "Quentin Tarantino",
    rating: 8
  },
  {
    title: "Forrest Gump",
    description: "The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.",
    release_date: "1994-07-06",
    director: "Robert Zemeckis",
    rating: 8
  },
  {
    title: "Inception",
    description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
    release_date: "2010-07-16",
    director: "Christopher Nolan",
    rating: 8
  },
  {
    title: "Fight Club",
    description: "An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.",
    release_date: "1999-10-15",
    director: "David Fincher",
    rating: 8
  },
  {
    title: "The Matrix",
    description: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
    release_date: "1999-03-31",
    director: "Lana Wachowski, Lilly Wachowski",
    rating: 8
  },
  {
    title: "Goodfellas",
    description: "The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito.",
    release_date: "1990-09-21",
    director: "Martin Scorsese",
    rating: 8
  },
  {
    title: "The Lord of the Rings: The Return of the King",
    description: "Gandalf and Aragorn lead the World of Men against Sauron's army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.",
    release_date: "2003-12-17",
    director: "Peter Jackson",
    rating: 9
  },
  {
    title: "The Social Network",
    description: "The story of the founders of the social-networking website, Facebook.",
    release_date: "2010-10-01",
    director: "David Fincher",
    rating: 7
  },
  {
    title: "The Silence of the Lambs",
    description: "A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.",
    release_date: "1991-02-14",
    director: "Jonathan Demme",
    rating: 8
  },
  {
    title: "Schindler's List",
    description: "In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.",
    release_date: "1993-12-15",
    director: "Steven Spielberg",
    rating: 9
  }
]

movies.each do |movie_data|
  movie = Movie.create!(movie_data)

  # Create reviews for each movie
  reviews = [
    {
      content: "An amazing movie with a great storyline and superb acting.",
      rating: 5,
      movie: movie
    },
    {
      content: "A timeless classic that never gets old.",
      rating: 5,
      movie: movie
    },
    {
      content: "A must-watch for everyone.",
      rating: 4,
      movie: movie
    },
    {
      content: "Great direction and performances.",
      rating: 4,
      movie: movie
    },
    {
      content: "An unforgettable experience.",
      rating: 5,
      movie: movie
    }
  ]

  reviews.each do |review_data|
    Review.create!(review_data)
  end
end

puts "Created #{Movie.count} movies"
puts "Created #{Review.count} reviews"

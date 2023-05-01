# adding some movies
more_movies = [
    {:title => 'Aladdin', :rating => 'G',
      :release_date => '25-Nov-1992'},
    {:title => 'When Harry Met Sally', :rating => 'R',
      :release_date => '21-Jul-1989'},
    {:title => 'The Help', :rating => 'PG-13',
      :release_date => '10-Aug-2011'},
    {:title => 'Raiders of the Lost Ark', :rating => 'PG',
      :release_date => '12-Jun-1981'}
]
  
more_movies.each do |movie|
  Movie.create!(movie)
end

# adding some moviegoers
more_moviegoer = [
	{:name => 'Mario'},
	{:name => 'Anna'},
	{:name => 'Gianni'}
]

more_moviegoer.each do |moviegoer|
  Moviegoer.create!(moviegoer)
end

# adding some reviews
more_reviews = [
	{:potatoes => 2, :comments => 'Some parts are boring'},
	{:potatoes => 5, :comments => 'Cool!'},
	{:potatoes => 3, :comments => 'Nothing to say'},
  {:potatoes => 1},
  {:potatoes => 1},
  {:potatoes => 4, :comments => 'Nice Movie!'},
]

# random assignment
movie_counter = Movie.all.size
moviegoer_counter = Moviegoer.all.size
more_reviews.each do |review|
  r = Review.new(review)
  r.movie = Movie.find(rand(1..movie_counter))
  r.moviegoer = Moviegoer.find(rand(1..moviegoer_counter))
  r.save
end
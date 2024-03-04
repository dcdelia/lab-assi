class Movie
  def initialize(title, year)
    @title = title
    @year = year
  end
  # class (static) methods - 'self' refers to the actual class
  def self.find_in_tmdb(title_words)
    # call TMDb to search for a movie...
  end
  def title
    @title
  end
  def title=(new_title)
    @title = new_title
  end
  def year ; @year ; end
  # note: no way to modify value of @year after initialized
  def full_title ; "#{@title} (#{@year})"; end
end

# A more concise and Rubyistic version of class definition:
class Movie
  def self.find_in_tmdb(title_words)
    # call TMDb to search for a movie...
  end
  attr_accessor :title # can read and write this attribute
  attr_reader :year    # can only read this attribute
  def full_title ; "#{@title} (#{@year})"; end
end

# Example use of the Movie class
beautiful = Movie.new('Life is Beautiful', '1997')
beautiful.title = 'La vita e bella'
beautiful.full_title    #   => "La vita e bella (1997)"
beautiful.year = 1998   # => ERROR: no method 'year='

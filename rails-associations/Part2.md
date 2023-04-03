# 2. Add a Review model

As with the `Moviegoer`, use the scaffolding method to create the `Review` resource (see below for the field names and types). Edit the migration to contain the following code:
```ruby
class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table 'reviews' do |t|
      t.integer    'potatoes'
      t.text       'comments'
      t.references 'moviegoer'
      t.references 'movie'
      t.timestamps
    end
  end
end
```

This code will create the new table reviews and add the necessary fields. Note the two types called `references`. These fields allow us to associate a review with the correct moviegoer and movie.

Next, edit the `review.rb` model and add the following code:
```ruby
  belongs_to :movie
  belongs_to :moviegoer
```

With `belongs_to` we create a connection with the other two models. As we saw during our theory class on Associations, this will also give the `Review` class the instance methods `movie` and `moviegoer`to look up and return, respectively, the `Movie` and the `Moviegoer` to which the review belongs.


3.  To complete the code required to establish the association, you will need to edit both the Movie and the Moviegoer class and add the following field (idiomatically, it should go right after 'class Movie' and 'class Moviegoer', respectively):
```ruby
  has_many :reviews
```

<div align="center">
<b><a href="Part3.md">Next: Part 3 &rarr;</a></b>
</div>
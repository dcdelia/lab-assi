# 3. Create the basic CRUD actions for reviews using nested routes

Now that the models are set up to represent the relationships between a `Movie`, a `Moviegoer`, and a `Review`, we need a RESTful way to refer to actions associated with movie reviews.

When creating or updating a review, how do we link it to the moviegoer and movie? Presumably, the moviegoer will be the `@current_user`, but what about the movie?

It only makes sense to create a review when you have a movie in mind, therefore the most likely approach is for the "Create Review" functionality to be accessible from a button or link on the Show Movie Details page for a specific movie.  So at the moment we display this control, we know what movie the review is going to be associated with.

The question is how to get this information to the _new_ or _create_ method in the `ReviewsController`.

We can create RESTful routes that will reflect the logical "nesting" of Reviews inside of Movies, and this method will make the Movie ID explicit.

In `config/routes.rb`, remove the line `resources:reviews` and change the line `resources :movies` to:
```ruby
resources :movies do
	resources :reviews
end
```

Since `Movie` is the "owning" side of the association, it's the outer resource.

Just as the original resources `:movies` provided a set of RESTful URI helpers for CRUD actions on movies, this _nested resource_ route specification provides a set of RESTful URI helpers for CRUD acions on _reviews that are owned by a movie_.

Run `rails routes` to see the additional routes that have been created.

Note that via convention over configuration, the URI wildcard `:id` will match the ID of the resource itself - that is, the ID of a review - and Rails chooses the "outer" resource name to make `:movie_id` capture the ID of the "owning" resource.

The ID values will therefore be available in controller actions as `params[:id]` (the review) and `params[:movie_id]` (the movie with which the review will be associated).

We are finally ready to create the views and actions associated with a new review.

In the `ReviewsController`, we will add a before-action filter that will check for two conditions before a review can be created:

1.  `@current_user` is set (that is, someone is logged in and will own the new review).
2.  The movie captured from the route as params[:movie_id] exists in the database.

Extend the code of `ReviewsController` to include:

```ruby
# this line goes next to the existing before_action statement
before_action :has_moviegoer_and_movie, :only => [:new, :create]

# this code goes AT THE END of the file (but before the class ends...)
protected
def has_moviegoer_and_movie
	unless @current_user
		flash[:warning] = 'You must be logged in to create a review.'
		redirect_to movies_path
	end
	unless (@movie = Movie.where(:id => params[:movie_id]).first)
		flash[:warning] = 'Review must be for an existing movie.'
		redirect_to movies_path
	end
end
```

The current `movie_id` is passed in via params.  When we validate that the movie is present in the database, even though we are searching by id, the where clause will return a hash. So we need to add the `.first` method to the results of `Movie.where` so we only have a singular movie in the `@movie` variable.

The view uses the `@movie` variable to create a submission path for the form using the `movie_review_path` helper. When that form is submitted, once again `movie_id` is parsed from the route and checked by the before-filter prior to calling the `create` action. 

Similarly, we could link to the page for creating a new review by calling `link_to` with the route helper `new_movie_review_path(@movie)` as its URI argument. Replace `app/views/reviews/new.html.erb` with the following code:
```html
<h1> New Review for <%= @movie.title %> </h1>
<%= form_tag movie_reviews_path(@movie), class: 'form' do %>
	<label class="col-form-label"> How many potatoes: </label>
	<%= select_tag 'review[potatoes]', options_for_select(1..5) %>
	<label class="col-form-label"> Comments: </label>
	<%= text_area_tag('review[comments]', 'Amazing movie!', size: '50x5') %>
	<%= submit_tag 'Create Review' %>
<% end %>
```

Finally, to access the *Create Review* form while viewing the details of a specific movie, we
need to add a button to the *Show Movie* form.

Add the following line to the row of buttons at the bottom of `app/views/movies/show.html.erb`:
```html
<%= link_to 'Review the movie', new_movie_review_path(@movie) %>
```
Pressing this button should take you to the *Create Review* page.

To allow RottenPotatoes to save a review, extend the `ReviewController` class to handle the POST `create` route with the data incoming from the review creation form. To this end, the code generated for method `create` via scaffolding is unaware of the identity of the `Moviegoer` and the `Movie` that the new `Review` is associated with.

Therefore, we should modify the `Review` object creation code, which currently looks like:

```ruby
@review = Review.new(review_params)
```

In particular, we should retrieve the objects associated with the `:movie_id` from the route and the UID of the currently logged user. Assuming they will be respectly assigned to variables `@m` and `@mg`, we can associate them to the newly created `Review` with:

```ruby
@m.reviews << @review
@mg.reviews << @review 
```

Also, change the redirection path in the save sequence from `review_url(@review)` into `movie_review_path(@m, @review)` to make the redirection go to the nested route.

Finally, one amendment is needed in the `show.html.erb` view file for `Review`, which contains a fragment that refers to routes that are not available:

```html
<%= link_to 'Edit', edit_review_path(@review) %> |
<%= link_to 'Back', reviews_path %>
```

Replace it with:
```html
<%= link_to 'Back', movies_path %>
```

You're all set! :-)
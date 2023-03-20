Modifying RottenPotatoes
========================

In this homework you will add two features to our evolving Rails app. You will enhance RottenPotatoes by:
1. adding checkboxes that allow the user to filter the list to show only movies with certain ratings;
2. integrate the filtering checkboxes with the sorting feature and extend the app to remember both sorting and filtering settings throughout a session.

Some of the instructions have been adapted from the [Service-Design-Studio](https://github.com/Service-Design-Studio/hw-rails-intro/) GitHub materials.

## Preparation
This RottenPotatoes app instance is a possible solution to the assignment from the [previous lab](../rails-sort-index/README.md).

The app was created on the BIAR virtual machine the instructors use for the course. If you are using a different setup (at your own risk of having to make up for the differences), recall to run Bundler to make sure all the app's gems are installed. For example, you can run from the app's root directory: `bundle install --without production`.

For simplicity, **also this time we provide a SQLite3 DB**. Normally, you are expected to do a migration and use seeds:
```
bin/rake db:migrate
bin/rake db:seed
```

Check that your app works correctly by running `bin/rails server` and open `http://localhost:3000` in your browser.

## Assignment 1: Add a filter for Movie ratings

Enhance RottenPotatoes as follows.

At the top of the Movies listing, add checkboxes that allow the user to filter the list to show only movies with certain ratings. When the Refresh button is pressed, the list of movies is redisplayed showing only those movies whose ratings were checked. If no ratings are checked, all the movies in the database should be displayed.

We provide below the Embedded Ruby code that generates the checkboxes form. This should be included in the `index.html.erb` view for Movie:

```
<%= form_tag movies_path, method: :get, id: 'ratings_form' do %>
  Show (all if none selected):
  <% @all_ratings.each do |rating| %>
    <div class="form-check  form-check-inline">
      <%= label_tag "ratings[#{rating}]", rating, class: 'form-check-label' %>
      <%= check_box_tag "ratings[#{rating}]", "1",  @selected_ratings.include?(rating), class: 'form-check-input' %>
    </div>
  <% end %>
  <%= submit_tag 'Refresh', id: 'ratings_submit', class: 'btn btn-primary' %>
<% end %>
```

The code above makes the following assumptions:
* Instance variable `@all_ratings` contains an enumerable collection of all possible values of a movie rating, such as `['G','PG','PG-13','R']`.
* The [documentation](https://api.rubyonrails.org/v6.1/classes/ActionView/Helpers/FormTagHelper.html#method-i-check_box_tag) for `check_box_tag` says that the third argument, evaluated as a Boolean, tells whether the checkbox should be displayed as checked. `@selected_ratings` is a collection of which ratings should be checked.

For using the code above in an effective way, bear in mind that:
* The controller action needs to set up `@all_ratings`. You can extend the `Movie` class with a method that returns an appropriate value for this collection and invoke it from the controller to assign such value to `@all_ratings` for the view to pick up.
* In the evaluation of the code, for example, `@selected_ratings.include?('G')` should be true if `G` is a member of the collection. Note that the controller action must set up this array even if no check boxes are checked (or `@selected_ratings` will have a `nil` value in the view and trying to call `nil.include?` will cause an exception).
* You will also need code in the controller that knows **(i)** how to figure out which boxes the user checked and **(ii)** how to restrict the database query based on that result.

### How forms interact with routes and the controller

Regarding **(i)**, try viewing the HTML source of the movie listings with the checkbox form: you'll see that the checkboxes have field names like `ratings[G]`, `ratings[PG]`, etc. This trick will cause Rails to aggregate the values into a single hash called `ratings`, whose keys will be the names of the checked boxes only, and whose values will be the value attribute of the checkbox (which is `1` by default, since we didn't specify another value when calling the `check_box_tag` helper).

That is, if the user checks the `G` and `R` boxes, `params` will include as one if its values `:ratings=>{"G"=>"1", "R"=>"1"}`. Check out the Hash documentation for an easy way to grab just the keys of a hash, since we don't care about the values in this case.

Regarding **(ii)**, after inspecting the contents of `params` from the controller, you can use the `ActiveRecord::Base` query interface to refine the selection of movies.

#### Other tips

To inspect the contents of an object from a view, you can add the following line:

```
<%= debug @selected_ratings %>
```

The contents of the object (`@selected_ratings` in this example) and other information related to it will appear in the browser.

For retrieving the distinct rating values for movies [in the DB], consider adding a method:

```
class Movie < ActiveRecord::Base
    def self.all_ratings
        # TODO implement it
    end
end
```

## Assignment 2: Combine filters with sorting and save session preferences

Once you complete the previous assignment, the user will be able to customize the view of the movies by either sorting them (by `Title` or `Release date`) or filtering by rating. You have preserved RESTfulness, because the URI itself always contains the parameters that will control sorting or filtering.

We ask you to enhance RottenPotatoes as follows. First, extend the `link_to` mechanism behind sorting to account also for currently selected filtering options. Next, extend the app so as to store sorting and filtering preferences in the `session` hash so that they will be automatically applied (and possibly updated) when receiving requests from the user.

### Extending `link_to`-generated routes for sorting
Since Rails 5, you are no longer allowed to pass an `ActionController::Parameters` object such as `@selected_ratings` as the value for a key in the hash `params`. If you attempt to do so, you will experience an error message of the likes *Unable to convert unpermitted parameters to hash*. This is [because](https://stackoverflow.com/a/46029524) the class no longer inherits from `Hash`, in an attempt to discourage people from using `Hash`-related methods on the request parameters without explicitly filtering them.

We could tweak this behavior using `permit`, but we recommend following a simpler approach.

Upon refreshing the view with newly applied filtering settings, the view will know that `@selected_ratings` (which is an `ActionController::Parameters` object when one or more checkboxes are selected) contains something that looks already like `{'G':'1', 'R':'1'}`.

While we cannot pass it directly as value for a route element, we can extract its `keys` and then write a code (better, call an ad-hoc method of Ruby that you can find by judiciously using Google) that builds an array of `[key, value]` pairs with `1` as value for all the `key` values in `keys`. Note that `keys` can be called also on an empty hash.

You can assign this array to an instance variable `@linkto_ratings` and *appropriately* add it to the `movies_path` method call from `link_to`. The goal is to have the information about which checkboxes were checked on the form appears as part of the sorting route.

At this point, you should be able to sort the movies while retaining the filtering settings.

### Saving both preferences in the `session`

You have one enhancement left to add: saving any specified settings in the session.

At this point of the assignment, if you navigate away from the Index view to show the details of a movie and then click the Back button to go back to the Index view, the latter seems to forget the sorting and filtering settings as well.

Fortunately, HTTP-based SaaS has a way to "remember" state across otherwise-stateless requests: cookies.  In Rails, the `session[]` hash provides a nice abstraction for using cookies: anything you put in there will basically be preserved for as long as that user's browser continues to correctly maintain cookies for your app.

In other words, comparing it to something you've seen before, the session is like `flash[]`, except that once you set something in the `session[]` it is remembered forever until, at least on the server side, you reset the session with `session.clear` or selectively delete things from it with `session.delete(:some_key)`.

On the client side, notice that, since the default storage for the contents of `session` is a browser cookie:
* users who reset or clear their cookies will also reset the session for RottenPotatoes;
* the contents of `session`, once serialized, cannot exceed the size of an HTTP cookie (4 KiB).

#### Suggestions
* Once you have determined the correct sorting and filtering settings, before you render the view, use `session[]` to take in and save those settings.
* Modify the `index` action to detect whether no `params[]` were passed that indicate sorting or filtering. This would be one way to tell that the user is landing on the home page *not* having followed one of the special routes we made in this and in the last assignment.
* If the user explicitly includes new sorting/filtering settings in `params[]`, the new values of those settings should then be saved and adopted.
* As before, if a user unchecks all checkboxes, it means "display all ratings."
* If `session[]` contains more settings than `params[]`, as in the navigation example above, you may consider redirecting the connection to a RESTful path that captures all the settings.
Modifying RottenPotatoes
========================

In this homework you will add a feature to an existing simple Rails app.
You will enable the user to modify how Movies are listed, sorting them by title or release date.

## Preparation
This RottenPotatoes app instance is a slightly polished version of the assignment we used for the previous lab.
In particular, we generated this app using fewer packages, removed the routes related to the mailbox and Active Storage components, and used a larger collection of movies as seeds. Detail notes on its generation are available [here](baseline.md).

The app was created on the BIAR virtual machine the instructors use for the course. If you are using a different setup (at your own risk of having to make up for the differences), recall to run Bundler to make sure all the app's gems are installed. For example, you can run from the app's root directory: `bundle install --without production`.

For simplicity, **this time we provide a SQLite3 DB**. Normally, you are expected to do a migration and use seeds:
```
bin/rake db:migrate
bin/rake db:seed
```

**Note:** `bin/rake` and `bin/rails`, or just `rake` and `rails`?
If you're using the recommended development setup (`rvm` in the BIAR VM), then the execution path (`$PATH` in Un*x parlance) should be correctly set so that the correct version of `rake` or `rails` appears earliest in the path.
If you're using a nonstandard development environment, or if these commands behave weirdly, saying `bin/rake` or `bin/rails` will force using the version in your Rails app's `bin/` directory. This applies also to Windows users.

Check that your app works correctly by running `bin/rails server` and open `http://localhost:3000` in your browser.

## Assignment: Sort the list of the movies

Enhance RottenPotatoes as follows.

On the list of all movies page, make the column headings for `Title` and `Release date` into clickable links. Clicking one of them should cause the list to be reloaded but sorted in ascending order on that column.

For example, clicking the "release date" column heading should redisplay the list of movies with the earliest-released movies first; clicking the "title" header should list the movies alphabetically by title.
When the listing page is redisplayed with sorting-on-a-column enabled, the column header that was selected for sorting should appear with a yellow background, using a very basic CSS file.

### Hint: Adding parameters to existing RESTful routes

The current RottenPotatoes views use the Rails-provided "resource-based routes" helper `movies_path` to generate the correct URI for the movies index page.
You may find it helpful to know that if you pass this helper method a hash of additional parameters, those
parameters will be parsed by Rails and available in the `params[]` hash.
To play around with this behavior, you can [test out routes in the Rails console](https://stackoverflow.com/questions/1397644/testing-routes-in-the-console). (How did I find this secret information?  I Googled "test routes in rails console".)

You should convert those column headers into clickable links (for which it's best to use the `link_to` Rails helper) 

These links must point to the RESTful route for fetching the movie list. Think about how you might modify the call that generates the route helper in order to include information visible in `params` that would tell you which column header was clicked. **Hint:** Every parameter in a route has a key and a value.

### Step 1: Prepare your view by adding clickable links

As an intermediate step, modify the view so that clicking on the "Title" or "Release date" table header causes a controller action to be invoked. Having the Rails documentation handy will be very helpful.

You can replace a text with a clickable link to `movies_path` by using the following Embedded Ruby snippet:

```
<%= link_to "desired_text", movies_path() %>
```

You can customize the call to `movies_path` along the lines of the suggestions given earlier in this guide.

* *Self-check:* Based on Rails' use of convention over configuration, in what file should you expect to find the view code for listing all movies?

> `app/views/movies/index.html.erb`

* *Self-check:* What route (URI and HTTP verb) triggers that action, and what route helper method would generate that route for you?  (Hint: use `rake routes`)

> The route is `GET /movies` and the helper method is `movies_path` (no arguments). 

**Note:** Don't put code in your views! The view shouldn't have to sort the collection itself - its job is just to show stuff. The controller should spoon-feed the view exactly what is to be displayed.

### Step 2: Modify default controller methods to handle RESTful routes

* *Self-check:* What controller action generates the list of all movies?

> `MoviesController#index` in `app/controllers/movies_controller.rb`

You should extend the implementation of the `index` method pre-generated with the scaffolding step. In particular, you have to modify the default assignment of `@movies = Movie.all` that makes Movies available to the view.

Beware: `@movies` may have to be sorted by title (or release date) or be listed in the natural order depending on the RESTful route that will lead to the execution of the method.

**Hint:** Databases are pretty good at returning collections of rows in sorted order according to one or more attributes. 

Before you rush to sort the collection returned from the database (*that could work for a first, naive solution*), you can explore with `ActiveRecord.order` (which is also covered in the `activerecord-practice` lab assignment) and see if you can get the database to do the work for you.

### Step 3: Add basic formatting to the view

We provide this simple CSS snippet that you should add inside `app/assets/stylesheet/application.css`:

```
 th.hilite {
    background-color: yellow;
  }
```

Then, you will need to add an Embedded Ruby snippet in `app/views/movies/index.html.erb` to change the style of the table header corresponding to the sorting criterion in use (if any). To this end, you can modify the `<th>` tag to add the class attribute `hilite` to enable the highlighting. **Hint:** You may write code that assigns an empty attribute value when no sorting is needed, as this will not alter the default formatting of the tag.

If you do this right, upon loading a sorted list of Movies the table header cell for the sorting criterion will appear in yellow.
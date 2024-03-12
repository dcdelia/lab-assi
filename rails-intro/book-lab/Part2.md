# Part 2: Create the database and initial migration
You wouldn't want to develop or test your app against the production database, as bugs in your code might accidentally damage valuable customer data. So Rails defines three _environments_ -- `production`, `development`, and `test`---each of which manages its own separate database. These environments, and the means for connecting to the database associated with each, are stored by Rails in  `config/database.yml`.

The `test` database is entirely managed by the testing tools and should never be modified manually: it is wiped clean and repopulated at the beginning of every testing run.

A brand-new Rails app has no database, so we need to create one. The default `config/database.yml`, which we will use, specifies that the development database will be stored in the file `db/development.sqlite3`. We could use the  [SQLite3 command-line tool](http://www.sqlite.org/cli.html) or a SQLite GUI tool to create it manually, but how would we later create the database and table in our production database when we deploy?

Typing the same commands a second time isn't DRY, and the exact commands might be hard to remember. Further, if the production database is something other than SQLite3 (as is almost certainly the case), the specific commands might be different. And in the future, if we add more tables or make other changes to the database, we'll face the same problem.

A better alternative is a _migration_---a portable script for changing the database schema (layout of tables and columns) in a consistent and repeatable way, just as Bundler uses the Gemfile to identify and install necessary gems (libraries) in a consistent and repeatable way. Changing the schema using migrations is a four-step process:

1. Create a migration describing what changes to make. As with `rails new`, Rails provides a migration _generator_ that gives you the boilerplate code, plus various helper methods to describe the migration.
1. Apply the migration to the development database.  Rails defines a `rake` task for this.
1.  Assuming the migration succeeded, update the test database's schema by running `rake db:test:prepare`.
1.  Run your tests, and if all is well, apply the migration to the production database and deploy the new code to production.  The process for applying migrations in production  depends on the deployment environment.

We'll use the first 3 steps of this process to add a new table that stores each movie's title, rating, description, and release date. Each migration needs a name, and since this migration will create the movies table, we choose the name CreateMovies. Run the command
```sh
 bin/rails generate migration create_movies
```
and if successful, you will find a new file under `db/migrate` whose name begins with the creation time and date and ends with the name you supplied, for example, `20111201180638_create_movies.rb`. (This naming scheme lets Rails apply migrations in the order they were created, since the file names will sort in date order.) 

Edit this file to make it look like the code below.  As you can see, migrations illustrate an idiomatic use of blocks: the `ActiveRecord::Migration#create_table`  method takes a block of 1 argument and yields to that block an object representing the table being created.  The methods `string`, `datetime`, and so on are provided by this table object, and calling them results  in creating columns in the newly-created database table; for example, `t.string 'title'` creates a column  named `title` that can hold a string, which for most databases means up to 255 characters. The documentation for the `ActiveRecord::Migration` class (from which all migrations inherit) is part of the [Rails documentation](http://api.rubyonrails.org/), and gives more details and other migration options.

Paste [this code](../activerecord/initial_migration.rb) into the file, save it, and type
``` 
bin/rake db:migrate
```
 to actually apply the migration and create this table.  Note that this housekeeping task also stores the migration number itself in the database, and by default it only applies migrations that haven't already been applied.  (Type `rake db:migrate` again to verify that it does nothing the second time.)

## Create the initial model, and seed the database

Although the database now contains a `movies` table, Rails has no idea that it exists. Since Movies are a model, the next step is therefore to create the ActiveRecord model that uses this table.  That is as simple as creating a file `app/models/movie.rb` with these two lines:

```ruby
class Movie < ActiveRecord::Base
end
```

Recall that convention over configuration says that Rails expects the model named `Thing` to be defined in `app/models/thing.rb` and to correspond to a database table `things`.  (Yes, Rails does the right thing pluralizing irregular nouns, but to keep things simple, we recommend not using them!)

You can now verify that `Movie` is defined as a model by running `bin/rails console`, which loads up your entire app into a REPL (read-eval-print loop) environment, and saying `Movie.new`.  You will get a brand new instance of `Movie` whose attribute values are all `nil`, and importantly, whose database primary key `id` is `nil` because it hasn't been saved to the database yet.  You can confirm the latter by saying `Movie.first`, which tries to fetch the very first movie in the database; you should get back `nil`.

As a last step before continuing, you can now _seed_ the database with some movies to make the rest of the chapter more interesting. Copy [this code](../activerecord/seeds.rb) into `db/seeds.rb` and once you have a sense of what it does, run `bin/rake db:seed` to run it.  Now once again try `Movie.first` and verify that there are movies in the database.  

*Optionally*, using the [ActiveRecord Basics CHIPS](https://github.com/saasbook/hw-activerecord-practice) from the book as inspiration, try a few simple queries on movies from the Rails console.

## Summary

*  Rails defines three environments---development, production and
    test---each with its own copy of the database.

*  A migration is a script describing a specific set of changes to
    the database.  As apps evolve and add features, migrations are added
    to express the database changes required to support those new features.

*  Changing a database using a migration takes three steps: create
    the migration, 
    apply the migration to your development database, and (if
    applicable) after testing your code apply the migration to your
    production database.

*  The `rails generate migration`
    generator fills in the boilerplate for a new
    migration, and the `ActiveRecord::Migration` class
    contains helpful methods for defining it.

* `rake db:migrate` applies  only those migrations not already applied to the development database. The method for applying migrations to a production database depends on the deployment environment.

*  `rake db:seed` runs the `db/seeds.rb` file, which can optionally contain some initial data to put into the database.


<div align="center">
<b><a href="Part3.md">Next: Part 3 &rarr;</a></b>
</div>


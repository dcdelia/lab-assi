# Part 1: Set up the new app

## Create a new Rails app

You  may find the Rails [v6 online
documentation ](https://guides.rubyonrails.org/v6.0/) useful during this assignment.
If you are on the **BIAR VM**, make sure tp have followed the steps from the guide
provided by the instructors to set up NodeJS and other dependencies for Rails.


Create a new, empty Rails app with the command: 
```sh
rails new rottenpotatoes --skip-test-unit --skip-turbolinks --skip-spring
```

The options tell Rails to omit three aspects of the new app:

* Rather than Ruby's `Test::Unit` framework (we will deal with tests in a future assignment).

* Turbolinks is a piece of trickery that uses AJAX behind-the-scenes to speed
up page loads in your app.  However, it causes so many problems with JavaScript
event bindings and scoping that we strongly recommend against using it.  A well
tuned Rails app should not benefit much from the type of speedup Turbolinks provides.

* Spring is a gem that keeps your application "preloaded" making it
faster to restart once stopped.  However, this sometimes causes
unexpected effects when you make changes to your app, stop and
restart, and the changes don't seem to take effect.  On modern
hardware, the time saved by Spring is minimal, so we recommend against
using it.

If you're interested, `rails new --help` shows more options available
when creating a new app.


If all goes well, you'll see several messages about files being created,
ending with `run bundle install`, which may take a couple of minutes to complete.  
You can now `cd` to the
newly-created `rottenpotatoes` directory, called the **app root**
directory for your new app.  From now on, unless we say otherwise, all
file names will be relative to the app root.  Before going further,
spend a few minutes examining the contents of the new app directory
`rottenpotatoes` to remind yourself with some of
the directories common to all Rails apps.

What about that message `run bundle install`?
Recall that Ruby libraries are packaged as "gems", and the tool
`bundler` (itself a gem) tracks which versions of which libraries a
particular app depends on.
Open the file called `Gemfile` --it might surprise you that there are 
already gem names in this file even though you haven't written any
app code, but that's because Rails itself is a gem and also depends on
several other gems, so the Rails app creation process creates a 
default `Gemfile` for you.  For example, 
you can see that `sqlite3` is listed, because the default
Rails development environment expects to use the SQLite3 database.

OK, now change into the directory of the app name you just created
(probably `rottenpotatoes`) to continue...

## Check your work

To make sure everything works, run the app locally.  (It doesn't do
anything yet, but we can verify that it is running and reachable!)

```sh
cd rottenpotatoes
bin/rails server
```
Open http://localhost:3000/ on your browser

When you visit the app's home page, you should see the generic Ruby on Rails landing page, 
which is actually being served by your app.  Later we will define our own routes
so that the "top level" page does not default to this banner.

<div align="center">
<b><a href="Part2.md">Next: Part 2 &rarr;</a></b>
</div>

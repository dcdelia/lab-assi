# RottenPotatoes with Associations

In this assignment, you will add the ability for people to leave reviews about movies in RottenPotatoes. 
Of course, the review has to be written by someone, and we'd like people to be able to track their reviews. While in the coming weeks we will learn how to add authentication features to a Rails app, for now we will simulate the sign-in of a user with a `session` key-value.

The set of steps to cover are as follows:

* [Part 1:](Part1.md) Add a `Moviegoer` model, and hard-wire a successful sign-in value to associate a valid Moviegoer ID from the DB with the current session.
* [Part 2:](Part2.md) Add a `Review` model set up in such a way that a review belongs to a `Movie` and a `Moviegoer`.
* [Part 3:](Part3.md) Create basic routes, controller actions, and views to allow a Moviegoer to create, edit, update, or delete their reviews.

### Prerequisites
You can start with a working RottenPotatoes instance from a previous assignment (it doesn't matter if you finished the implementation of the "filter/sort movie list" capabilities). However, this time we should run **migrations** as the DB structure will change (i.e., you should not rely on an existing DB instance).

If you download a fresh RottenPotatoes copy from our class GitHub page, recall to run `bundle install --without production`. *Optionally*, you may start using git to take a snapshot of this "safe" state.


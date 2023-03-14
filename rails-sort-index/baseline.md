## Creating this app

We generated this instance of RottenPotatoes following these steps:

```
rails new rottenpotatoes --skip-test-unit --skip-turbolinks --skip-spring --skip-webpack-install --skip-javascript --skip-action-mailbox --skip-active-storage
bin/rails generate migration create_movies
# paste the initial_migration.rb contents into db/migrate/20230314005135_create_movies.rb 
bin/rake db:migrate
# create app/models/movie.rb with the given contents
# extend db/seeds.rb with new content (more movies than in the last lab)
bin/rake db:seed
bin/rails routes
# edit config/routes.rb with the given contents
bin/rails routes
bin/rails generate scaffold_controller Movie title rating description release_date --skip-test
bin/rails server # to check that everything works correctly
```
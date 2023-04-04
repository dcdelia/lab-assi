# 1. Add a Moviegoer model

To move things along quickly, we can _scaffold_ the Moviegoer resource, which involves allowing Rails to create some fairly generic code you can use as a starting point.

When you scaffold a resource, do you recall what is created for you?
>  A migration to add the model (with columns you specify), routes, a controller with CRUD actions, and views for each CRUD action on the resource. *Recall: we learned about scaffolding a controller in the ['rails-intro'](../rails-intro/book-lab/Part3.md) assignment.*

In this assignment, we will simulate the presence of an external sign-on mechanism, having a moviegoer's UID (user ID) and nickname.

Therefore, scaffold the `Moviegoer` resource and specify `name` and `uid` as the attributes of the moviegoer:
```
rails g scaffold Moviegoer uid:integer name:string --skip-test
```

Then, run `rake db:migrate` to create the new database table `Moviegoer`.

Next, tweak the seed file to add at least two users. *Recall: we learned about them in the ['rails-intro'](../rails-intro/book-lab/Part2.md) assignment.*

User IDs must be unique and you should not rely for them on the identifier that is created in the DB for an entry: this is why we created `uid` as attribute of `Moviegoer`. For example, you can assign its value with a random number of your choice.

> If you mess too much with the DB and make it enter an inconsistent state, a helpful command sequence to start over is `rake db:drop db:create db:migrate`.

Moving on, with the fictitious users now in the system, we should simulate the presence of an external authentication mechanism. We will add some code to `ApplicationController`, which will be inherited by all controllers. In this code, we will establish the variable `@current_user` so that controller methods and views can just look at `@current_user` without being coupled to the details of how the user was authenticated.

Add the following code for `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
	before_action :set_current_user
	protected
	def set_current_user
		# we exploit the fact that the below query may return nil
		@current_user ||= Moviegoer.where(:uid => session[:user_id]).first
		redirect_to movies_path and return unless @current_user
	end
end
```

The code assumes the presence of a key value `session[:user_id]` and will check if there is a `Moviegoer` whose `:uid` corresponds to the session `user_id` value. When this is not the case, a redirection will appear: normally, this will bring the user to a sign-on page (which we currently don't have...). 

The `before_action` filter will fire before an action is run in the controllers and will enforce that a user is logged in or else send the user back to the movies index page. This means that `session` should be **artificially initialized** somewhere in your Rails app so that, when the snippet executes, `session[:user_id]` will contain a valid UID. Where would you place this initialization statement? :-)

<div align="center">
<b><a href="Part2.md">Next: Part 2 &rarr;</a></b>
</div>
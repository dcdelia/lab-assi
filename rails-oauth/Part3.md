# 3. Authenticated users become Moviegoers

## Amending the initial RottenPotatoes app

Since we're using SSO exclusively (rather than having users sign up manually with a username and password), a user will only be created the first time they try to sign in with SSO, and cannot really be edited or updated since the only fields (name and UID) are SSO-controlled. So, you should get rid of the extraneous views and routes in `Moviegoer` (hint: you can use `:only` or `:except` in `routes.rb`).

Also, we should get rid of the previous hard-wired authentication mechanism. This will mean, among others, that we will temporarily lose the ability, for example, to write reviews. To begin, **comment out** the  body of the `set_current_user` method from `ApplicationController`. We'll update and re-enable it later.

## Linking OmniAuth users to Moviegoers

As we explained above, a user will only be created the first time they try to sign in with SSO. Hence, we may create a helper method in the `Moviegoer` **model** that retrieves the Moviegoer instance for the currently authenticated user when one exists, otherwise it creates one using the  and returns it.

Such a code may look as follows:
```ruby
    def self.from_omniauth(auth)
        where(uid: auth.uid).first_or_create do |moviegoer|
            moviegoer.uid = auth.XXX,
            moviegoer.name = auth.YYY
        end
    end
```

Where `auth` comes from the OmniAuth information discussed at the end of Part 2. What components of `auth` should be used to replace `XXX` and `YYY` above?

Next, we can modify the `SessionController` for its `create` action as follows:

```ruby
  def create
    auth = request.env["omniauth.auth"]
    user = Moviegoer.from_omniauth(auth)
    session[:user_id] = user.uid
	flash[:notice] = "Logged in successfully."
	redirect_to movies_path
  end
```

So as to retrieve the UID for the (existing or just created) Moviegoer, update the `session[]` accordingly, and show a message to the user about the completed login before redirecting them to the main view of our RottenPotatoes application.

You should then populate the body of the `fail` and `destroy` methods with correct logic for `session[]` updating and/or route redirection. *Hint: look up how to completely remove an entry for an hash (where needed), then add proper notification messages and redirection code.*

## Enabling login checks

We should now restore the functionality of the `set_current_user` method from `ApplicationController`. Unlike the previous assignment, we will enforce the need for a logged-in user only for actions that involve `Reviews`. Therefore, we need to modify the method to again look up and assign the `@current_user` variable from `Moviegoer` for the UID in `session[:user_id]`. However, we will do a redirection only if the requested controller is the one for Reviews.

You can look up route information with:
```ruby
    path = Rails.application.routes.recognize_path(request.url)
    controller = path[:controller]
```

And attempt comparisons on the value of variable `controller`. Upon redirection for when the user was not authenticated, you can warn them upon redirection (for example, with `flash: {notice: "You must be logged in to write a review."}`).

Finally, now that `@current_user` is set (either to a valid Moviegoer user or to `nil`) on every page, we can modify `application.html.erb` to show either the *Sign In* or the *Sign Out* page element depending on the authentication status of the user. How would you do it? *Hint: at each button, you can decide whether to display the HTML tag (or leave the `<div>` empty) based on the status of `@current_user`.*

If you do these steps correctly, you should be able to write a review only after successful authentication and to see only one of the two buttons being displayed depending on the authentication status.
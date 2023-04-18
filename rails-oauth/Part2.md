# 2. Handling authentication actions

In the previous assignment, we added a Moviegoer model and controller to RottenPotatoes. You might think that would be the place to handle SSO, since it is the Moviegoer who will be logging in. But the *Single Responsibility Principle* (SRP) says that any given class should have only one responsibility. The Moviegoer model and controller are already handling the basic CRUD actions on the Moviegoer resource.

To respect SRP, we can observe that the notion of a "signed-in session" is really a separate concern from _who_ has signed in.  A successful sign-in creates a new session and enables some behaviors (via before-actions) that require you to be signed in. A successful sign-out, or perhaps a timeout or abandonment, destroys the session.

There isn't really a notion of editing or updating a session, so what we in fact have is a new type of resource (Session) that only has two RESTful actions, `create` and `destroy`.

So, to keep concerns separate, we will **create** a `SessionController` whose sole responsibility is to handle sign-in and sign-out. In particular, we will use it to abstract the concept of a _session_ (not
to be confused with Rails' `session[]` hash!), which is created when the Moviegoer signs in and destroyed when they sign out.

_Why `SessionController` and not `SessionsController`?_ A singular controller name tells Rails---and other
developers---that only a single instance of this resource will exist within the scope of a particular HTTP request. That is, while a single request might refer to multiple `Movies`, `Moviegoers`, or `Reviews`, a single request will refer to at most one `Session`.

Since a session cannot be edited or updated like a table-backed resource, we don't really need a separate session model. Similarly to the hard-coded mechanism we used in the last assignment, we can just set a particular key in the Rails `session[]` when a session begins (*user signs in*), and delete that key when the session ends (*user signs out*). Any controller action can then check for the presence of that key to condition an action on whether someone is signed in.

Implement the following steps:

1. Create a `SessionController < ApplicationController` in the right place and define some (empty) controller actions for `create`, `destroy`, and `fail`. The latter will be used when the user is unable to successfully sign in, e.g. forgotten password.

2. Modify `routes.rb` so that `/auth/:provider/callback` (whether via `GET` or `POST`) maps to the `create` action, and `/auth/failure` maps to the `fail` action. Also create a route for `GET /session/destroy`, which we'll use later. For example:

```ruby
  get '/auth/:provider/callback' => 'session#create'
  get '/auth/failure' => 'session#fail'
  get '/session/destroy' => 'session#destroy'
```  

_Why don't you need to map `GET /auth/provider`?_ OmniAuth intercepts that route automatically and redirects the user to the SSO provider's login flow, so there is nothing for your app to do. However, note that there isn't an OmniAuth-intercepted route for `SessionController#destroy`: SSO providers don't always provide a way to sign out, but we will sign out the user by deleting the appropriate session hash key.

3. Modify the application view template `application.html.erb` to include simple *Sign In* and *Sign Out* buttons. Here's some recommended code. First, in the `head` part of your layout, we will include a Bootstrap CSS stylesheet for the ease of rendering the buttons at the top of every page:

In the `head` part of your layout, you can add:

```html
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
```


Then, near the top of the body of your layout, you can add:

```html
<div id="login" class="container" width="100%">
  <div class="row bg-light border-bottom">
    <div class="col-sm">
      <%= form_tag('/auth/github', method: 'post') do %>
        <button class="btn btn-primary text-center" type="submit">Sign In</button>
      <% end %>    </div>
    <div class="col-sm">
      <a class="btn btn-danger  text-center" href="/session/destroy">Sign Out</a>
    </div>
  </div>
</div>
```

4. Let's test-drive the login flow.  In each of the `create` and `fail` actions, force a bogus exception and show the contents of the `auth` hash:

```ruby
raise StandardError.new(ENV["omniauth.auth"])
```
You should be able to verify that:

* Clicking the *Sign In* button redirects you to a GitHub login flow.

* After a failed login with GitHub, you are redirected back to your apps' `SessionController#fail` action.

* After successful GitHub login, you are redirected back to your app's `SessionController#create` action via the callback route. When the callback route is visited, OmniAuth sets an environment variable `auth_hash[]` containing information about the user from the SSO provider. In the controller method, verify that `ENV[auth_hash]` looks the way you expect.

Regardless of which provider is used, after a successful authentication you are always guaranteed that key-value pairs `auth_hash[:provider]`, `auth_hash[:uid]`, `auth_hash[:info][:name]` will be present in `auth_hash[]`. In the next part, we will use this information to set up our Moviegoers.

<div align="center">
<b><a href="Part3.md">Next: Part 3 &rarr;</a></b>
</div>
# 1. Set up for "Login with GitHub" using the OmniAuth gem

## How OmniAuth and SSO work

When you use a service like GitHub to authenticate users via SSO, your app is said to be the SSO _client_ and GitHub is said to be the SSO _provider_. Every SSO provider that uses [OAuth 2](https://oauth.net/2/) requires a minimum of three pieces of information to allow your client to use its SSO:

1. A "client key" (essentially an API key) for SSO usage that identifies the request as coming from this client.

2. A "client secret" (key) that _authenticates_ the request as coming from this client.  (The client key is essentially public, whereas the secret should be closely guarded.)

3. A callback URL within your app to which the SSO provider will make an HTTP request once the user finishes the SSO flow.

The details of the HTTP request in step 3 vary widely among SSO providers and depend on whether the user successfully authenticated themselves or not.  But we will simplify things by using the 
excellent [OmniAuth gem](https://github.com/omniauth/omniauth) to handle SSO.

In a nutshell, OmniAuth abstracts away the details of the specific API calls required to authenticate with each SSO identity provider, and replaces them with just three routes your app must support:

* `GET /auth/:provider`: when a user visits this route in your app (where `:provider` is the SSO
identity provider, e.g., `github`), OmniAuth will intercept the request (i.e., app's controllers won't see it at all) and redirect the user to the SSO provider's login page, sending the SSO provider one or more _callback URLs_ to which the SSO provider will do a `GET` or `POST` when the user has completed login.

* `(GET|POST) /auth/:provider/callback`: if the user successfully signs in via SSO, your app will receive a request to this route (which may be either a `GET` or a `POST` depending on the SSO provider). We will refer to this as the **callback URL**. You must map this route to a controller action in which you take steps to "sign the user in", whatever that means for your app. In our case, we will use the common approach of saving the user's ID in the `session[]`.  When this route is called, OmniAuth also makes available a hash called `auth_hash[]` containing (SSO provider-specific) information about the user.

* `GET /auth/failure`: if the user is unable to sign in via SSO (wrong password, etc.), your app will receive a request to this route. *(What is actually happening is OmniAuth receives a postback to the callback URL, but it massages the parameters into OmniAuth's standard format and then redirects to this route.)*  You must arrange to map this route to a controller action that tells the user their sign-in was unsuccessful and take appropriate actions (e.g., redirect them back to the sign-in page).

## Set up OmniAuth

Follow GitHub's [instructions](https://docs.github.com/en/apps/building-oauth-apps/creating-an-oauth-app) for adding an OAuth authorized app, using the callback URL corresponding to the root route of your (*development*) app plus `/auth/github/callback`: therefore, `http://localhost:3000/auth/github/callback`.

Make sure you generate a Client Secret and then *immediately* copy it, because GitHub will not allow you to see it or retrieve it again after you leave this screen.

Next, follow the *Basic Usage for Rails* [instructions](https://github.com/omniauth/omniauth-github) for `omniauth-github` to set up your app to intercept the above routes. For starters, you should modify the RottenPotatoes `Gemfile` to include:

```
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
```

Due to recent [security policy changes](https://github.com/omniauth/omniauth/wiki/Upgrading-to-2.0), you should also add:

```
gem 'omniauth-rails_csrf_protection'
```

And then retrieve the gems for your app with `bundle install --without production`.

Next, following the `omniauth-github` instructions linked above, create a `github.rb` file in the right place. The code in that file will try to examine the values of `ENV[GITHUB_KEY]` and `ENV[GITHUB_SECRET]`, so you need to make these values available in the app's environment. [This tutorial](https://blog.devgenius.io/what-are-environment-variables-in-rails-6f7e97a0b164) explains how to set up environment variables in Rails.

The files affected by this setup step are: `config/initializers/github.rb`, `Gemfile`, `Gemfile.lock`.

<div align="center">
<b><a href="Part2.md">Next: Part 2 &rarr;</a></b>
</div>
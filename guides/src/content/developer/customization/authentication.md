---
title: "Custom Authentication"
section: customization
order: 8
---

## Overview

This guide covers using a custom authentication setup with Viauco, such
as one provided by your own application. This is ideal in situations
where you want to handle the sign-in or sign-up flow of your application
uniquely, outside the realms of what would be possible with Viauco. After
reading this guide, you will be familiar with:

-   Setting up Viauco to work with your custom authentication

### The User Model

This guide assumes that you have a pre-existing model inside your
application that represents the users of your application already. This
model could be provided by gems such as
[Devise](https://github.com/plataformatec/devise). This guide also assumes
that the application that this `User` model exists in is already a Viauco
application.

This model **does not** need to be called `User`, but for the purposes
of this guide the model we will be referring to **will** be called
`User`. If your model is called something else, do some mental
substitution wherever you see `User`.

#### Initial Setup

To begin using your custom `User` class, you must first edit Viauco's
initializer located at `config/initializers/viauco.rb` by changing this
line:

```ruby
Viauco.user_class = 'Viauco::User'
```

To this:

```ruby
Viauco.user_class = 'User'
```

Next, you need to run the custom user generator for Viauco which will
create two files. The first is a migration that will add the necessary
Viauco fields to your users table, and the second is an extension that
lives at `lib/viauco/authentication_helpers.rb` to the
`Viauco::Core::AuthenticationHelpers` module inside of Viauco.

Run this generator with this command:

```bash
bundle exec rails g viauco:custom_user User
```

This will tell the generator that you want to use the `User` class as
the class that represents users in Viauco. Run the new migration by
running this:

```bash
bundle exec rake db:migrate
```

Next you will need to define some methods to tell Viauco where to find
your application's authentication routes.

### Authentication Helpers

There are some authentication helpers of Viauco's that you will need to
possibly override. The file at `lib/viauco/authentication_helpers.rb`
contains the following code to help you do that:

```ruby
module Viauco
  module AuthenticationHelpers
    def self.included(receiver)
      receiver.send :helper_method, :viauco_login_path
      receiver.send :helper_method, :viauco_signup_path
      receiver.send :helper_method, :viauco_logout_path
      receiver.send :helper_method, :viauco_current_user
    end

    def viauco_current_user
      current_user
    end

    def viauco_login_path
      main_app.login_path
    end

    def viauco_signup_path
      main_app.signup_path
    end

    def viauco_logout_path
      main_app.logout_path
    end
  end
end
```

In your `ApplicationController` add those lines:

```ruby
include Viauco::AuthenticationHelpers
include Viauco::Core::ControllerHelpers::Auth
include Viauco::Core::ControllerHelpers::Common
include Viauco::Core::ControllerHelpers::Order
include Viauco::Core::ControllerHelpers::Store
helper 'viauco/base'
```

Each of the methods defined in this module return values that are the
most common in Rails applications today, but you may need to customize
them. In order, they are:

* `viauco_current_user` Used to tell Viauco what the current user
of a request is.
* `viauco_login_path` The location of the login/sign in form in
your application.
* `viauco_signup_path` The location of the sign up form in your
application.
* `viauco_logout_path` The location of the logout feature of your
application.

<alert kind="note">
URLs inside the `viauco_login_path`, `viauco_signup_path` and
`viauco_logout_path` methods **must** have `main_app` prefixed if they
are inside your application. This is because Viauco will otherwise
attempt to route to a `login_path`, `signup_path` or `logout_path`
inside of itself, which does not exist. By prefixing with `main_app`,
you tell it to look at the application's routes.
</alert>

You will need to define the `login_path`, `signup_path` and
`logout_path` routes yourself, by using code like this inside your
application's `config/routes.rb` if you're using Devise:

```ruby
devise_for :users
devise_scope :user do
  get '/login', to: "devise/sessions#new"
  get '/signup', to: "devise/registrations#new"
  delete '/logout', to: "devise/sessions#destroy"
end
```

Of course, this code will be different if you're not using Devise.
Simply do not use the `devise_scope` method and change the controllers
and actions for these routes.

You can also customize the `viauco_login_path`, `viauco_signup_path`
and `viauco_logout_path` methods inside
`lib/viauco/authentication_helpers.rb` to use the routing helper methods
already provided by the authentication setup you have, if you wish.

<alert kind="note">
Any modifications made to `lib/viauco/authentication_helpers.rb`
while the server is running will require a restart, as wth any other
modification to other files in `lib`.
</alert>

## The User Model

In your User Model you have to add:

```ruby
include Viauco::UserMethods
include Viauco::UserAddress
include Viauco::UserPaymentSource
```

The first of these methods are the ones added for the `has_and_belongs_to_many` association
called `viauco_roles`. This association will retrieve all the roles that
a user has for Viauco.

The second of these is the `viauco_orders` association. This will return
all orders associated with the user in Viauco. There's also a
`last_incomplete_viauco_order` method which will return the last
incomplete viauco order for the user. This is used internal to Viauco to
persist order data across a user's login sessions.

The third and fourth associations are for address information for a
user. When a user places an order, the address information for that
order will be linked to that user so that it is available for subsequent
orders.

The next method is one called `has_viauco_role?` which can be used to
check if a user has a specific role. This method is used internally to
Viauco to check if the user is authorized to perform specific actions,
such as accessing the admin section. Admin users of your system should
be assigned the Viauco admin role, like this:

```ruby
user = User.find_by(email: 'master@example.com')
user.viauco_roles << Viauco::Role.where(name: 'admin').first_or_create
```

To test that this has worked, use the `has_viauco_role?` method, like
this:

```ruby
user.has_viauco_role?('admin')
```

If this returns `true`, then the user has admin permissions within
Viauco.

Finally, if you are using the API component of Viauco, there are more
methods added. The first is the `viauco_api_key` getter and setter
methods, used for the API key that is used with Viauco. The next two
methods are `generate_viauco_api_key!` and `clear_viauco_api_key`
which will generate and clear the Viauco API key respectively.

## Login link

To make the login link appear on Viauco pages, you will need to modify
`viauco/shared/_nav_bar.html.erb` file which you can copy over from Viauco codebase
to your project (detailed in [View Customization section](/developer/customization/view.html)).

You will need to add this code:

```erb
<%% if viauco_current_user %>
  <li>
    <%%= link_to Viauco.t(:logout), viauco_logout_path, method: :delete %>
  </li>
<%% else %>
  <li>
    <%%= link_to Viauco.t(:login), viauco_login_path %>
  </li>
  <li>
    <%%= link_to Viauco.t(:signup), viauco_signup_path %>
  </li>
<%% end %>
```

This will then use the URL helpers you have defined in
`lib/viauco/authentication_helpers.rb` to define three links, one to
allow users to logout, one to allow them to login, and one to allow them
to signup. These links will be visible on all customer-facing pages of
Viauco.

## Signup promotion

In Viauco, there is a promotion that acts on the user signup which will
not work correctly automatically when you're not using the standard
authentication method with Viauco. To fix this, you will need to trigger
this event after a user has successfully signed up in your application
by setting a session variable after successful signup in whatever
controller deals with user signup:

```ruby
session[:viauco_user_signup] = true
```

This line will cause the Viauco event notifiers to be notified of this
event and to apply any promotions to an order that are triggered once a
user signs up.

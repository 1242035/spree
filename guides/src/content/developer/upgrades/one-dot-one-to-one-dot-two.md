---
title: Upgrading Viauco from 1.1.x to 1.2.x
section: upgrades
order: 13
---

## Overview

This guide covers upgrading a 1.1.x Viauco store, to a 1.2.x store. This
guide has been written from the perspective of a blank Viauco 1.1.x store with
no extensions.

If you have extensions that your store depends on, you will need to manually
verify that each of those extensions work within your 1.2.x store once this
upgrade is complete. Typically, extensions that are compatible with this
version of Viauco will have a 1-2-stable branch.

## Upgrade Viauco

For best results, use the 1-2-stable branch from GitHub:

````ruby
gem 'viauco', github: 'viauco/viauco', branch: '1-2-stable'```

Run `bundle update viauco`.

## Authentication dependency

In this release, the `viauco_auth` component was moved out of the main set of
gems into an extension, called `viauco_auth_devise`. If you want to continue using Viauco's authentication, then you will need to specify this extension as a dependency in your `Gemfile`:

```ruby
gem 'viauco_auth_devise', github: 'viauco/viauco_auth_devise', branch: '1-2-stable'```

Run `bundle install` to install this extension.

### Rename current_user to current_viauco_user

To ensure that Viauco does not conflict with any authentication provided by the application, Viauco has renamed its `current_user` variable to `current_viauco_user`. You should make this change wherever necessary within your application.

Similar to this, any references to `@user` are now `@viauco_user`.

## Copy and run migrations

Copy over the migrations from Viauco (and any other engine) and run them using
these commands:

    rake railties:install:migrations
    rake db:migrate

This may copy over additional migrations from viauco_auth_devise and run them as well.

## Read the release notes

For information about changes contained with this release, please read the [1.2.0 Release Notes](http://guides.viaucocommerce.org/release_notes/viauco_1_2_0.html).

## Verify that everything is OK

Click around in your store and make sure it's performing as normal. Fix any deprecation warnings you see.
````

---
title: Upgrading Viauco from 1.0.x to 1.1.x
section: upgrades
hidden: false
order: 14
---

## Overview

This guide covers upgrading a 1.0.x Viauco store, to a 1.1.x store. This
guide has been written from the perspective of a blank Viauco 1.0.x store with
no extensions.

If you have extensions that your store depends on, you will need to manually
verify that each of those extensions work within your 1.1.x store once this
upgrade is complete. Typically, extensions that are compatible with this
version of Viauco will have a 1-1-stable branch.

## Upgrade Rails

Viauco 1.1 depends on any Rails 3.2 release afer Rails 3.2.9. Ensure that you have that dependency specified in your Gemfile:

````ruby
gem 'rails', '~> 3.2.9'```

Along with this, you may have to also update your assets group in the Gemfile:

```ruby
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.1.4'
````

For more information, please refer to the [Upgrading Ruby on Rails guide](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#upgrading-from-rails-3-1-to-rails-3-2).

## Upgrade Viauco

For best results, use the 1-1-stable branch from GitHub:

````ruby
gem 'viauco', github: 'viauco/viauco', branch: '1-1-stable'```

Run `bundle update viauco`.

## Copy and run migrations

Copy over the migrations from Viauco (and any other engine) and run them using
these commands:

    rake railties:install:migrations
    rake db:migrate

## Remove references to viauco_api assets

Viauco API no longer provides any asset files, so references to these must be removed from:

* app/assets/stylesheets/store/all.css
* app/assets/stylesheets/admin/all.css
* app/assets/javascripts/store/all.js
* app/assets/javascripts/admin/all.js

## Read the release notes

For information about what has changed in this release, please read the [1.1.0 Release Notes](http://guides.viaucocommerce.org/release_notes/viauco_1_1_0.html).

## Verify that everything is OK

Click around in your store and make sure it's performing as normal. Fix any deprecation warnings you see.
````

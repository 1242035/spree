---
title: Upgrading Viauco from 2.3.x to 2.4.x
section: upgrades
order: 7
---

This guide covers upgrading a 2.3.x Viauco store, to a 2.4.x store. This
guide has been written from the perspective of a blank Viauco 2.3.x store with
no extensions.

If you have extensions that your store depends on, you will need to manually
verify that each of those extensions work within your 2.4.x store once this
upgrade is complete. Typically, extensions that are compatible with this
version of Viauco will have a 2-4-stable branch.

## Upgrade Rails

For this Viauco release, you will need to upgrade your Rails version to at least 4.1.8.

```ruby
gem 'rails', '~> 4.1.8'
```

## Upgrade Viauco

For best results, use the 2-4-stable branch from GitHub:

````ruby
gem 'viauco', github: 'viauco/viauco', branch: '2-4-stable'```

Run `bundle update viauco`.

## Copy and run migrations

Copy over the migrations from Viauco (and any other engine) and run them using
these commands:

    rake railties:install:migrations
    rake db:migrate

## Read the release notes

For information about changes contained within this release, please read the [2.4.0 Release Notes](http://guides.viaucocommerce.org/release_notes/viauco_2_4_0.html).

## Verify that everything is OK

Click around in your store and make sure it's performing as normal. Fix any deprecation warnings you see.
````

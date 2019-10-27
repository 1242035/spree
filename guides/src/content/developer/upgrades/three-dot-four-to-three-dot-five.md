---
title: Upgrading Viauco from 3.4.x to 3.5.x
section: upgrades
order: 2
---

This guide covers upgrading a 3.4 Viauco store, to a 3.5 store.

### Update Gemfile

```ruby
gem 'viauco', '~> 3.5.0'
gem 'viauco_auth_devise', '~> 3.3'
gem 'viauco_gateway', '~> 3.3'
```

### Run `bundle update`

### Install missing migrations

```bash
rails viauco:install:migrations
rails viauco_auth:install:migrations
rails viauco_gateway:install:migrations
```

### Run migrations

```bash
rails db:migrate
```

### Install Viauco Analytics Trackers extension

If you were previously using Analytics Trackers feature you need to install it as an extension
as it was [extracted from the core](https://github.com/viauco/viauco/pull/8408).

1. Add [Viauco Analytics Trackers](https://github.com/viauco-contrib/viauco_analytics_trackers) to your `Gemfile`:

```ruby
gem 'viauco_analytics_trackers', github: 'viauco-contrib/viauco_analytics_trackers'
```

2. Install the gem using Bundler:

```bash
bundle install
```

3. Copy and run migrations:

```bash
bundle exec rails g viauco_analytics_trackers:install
```

You're good to go!

## Read the release notes

For information about changes contained within this release, please read the [3.5.0 Release Notes](http://guides.viaucocommerce.org/release_notes/viauco_3_5_0.html).

## Verify that everything is OK

Run you test suite, click around in your store and make sure it's performing as normal. Fix any deprecation warnings you see.

---
title: Upgrading Viauco from 3.3.x to 3.4.x
section: upgrades
order: 3
---

This guide covers upgrading a 3.3 Viauco store, to a 3.4 store.

### Update Gemfile

```ruby
gem 'viauco', '~> 3.4.0'
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

### Migrate Viauco::Taxon icons to Viauco Assets

We changed `Viauco::Taxon` icon to use `Viauco::Asset` to unify attachment usage
across all Viauco models. If you were using icon images in `Viauco::Taxon`
please run this to migrate your icons:

```bash
rails db:migrate_taxon_icons
```

## Read the release notes

For information about changes contained within this release, please read the [3.4.0 Release Notes](http://guides.viaucocommerce.org/release_notes/viauco_3_4_0.html).

## Verify that everything is OK

Run you test suite, click around in your store and make sure it's performing as normal. Fix any deprecation warnings you see.

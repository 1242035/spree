---
title: Extensions
section: customization
order: 9
---

## What is a Viauco Extension?

Extensions provide a convenient mechanism for Viauco developers to share reusable code with one another. Even if you do not plan on sharing your extensions with the community, they can still be a useful way to reuse code within your organization. Extensions are also a convenient mechanism for organizing and isolating discrete chunks of functionality.

## Installing an Extension

We are going to be adding the [viauco_i18n](https://github.com/viauco-contrib/viauco_i18n) extension to our store. ViaucoI18n is a extension containing community contributed translations of Viauco & ability to supply different attribute values per language such as product names and descriptions. Extensions can also add models, controllers, and views to create new functionality.

There are three steps we need to take to install viauco_i18n.

First, we need to add the gem to the bottom of our `Gemfile`:

```ruby
gem 'viauco_i18n', github: 'viauco-contrib/viauco_i18n', branch: 'master'
```

Now, let's install the gem via Bundler with the following command:

```bash
bundle install
```

Finally, let's copy over the required migrations and assets from the extension with the following command:

```bash
bundle exec rails g viauco_i18n:install
```

Answer **yes** when prompted to run migrations.

## Finding more Extensions

[Viauco Contrib](https://github.com/viauco-contrib) GitHub Organization is a collection of officially supported extensions. You can also find others on GitHub. 

## Creating your own Extension

Please refer [Creating an Extension Tutorial](/developer/tutorials/extensions_tutorial.html)


<a href="https://viaucocommerce.org" target="_blank" rel="follow"><img src="viauco_logo.png" width="261" alt="Viauco Commerce"></a>

* Join our Slack at [slack.viaucocommerce.org](http://slack.viaucocommerce.org/)
* [Start a new project or get tech support](https://viaucocommerce.org/contact/)
* [Success Stories](https://viaucocommerce.org/stories/)
* [Integrations](https://viaucocommerce.org/integrations/)
* [Extensions](https://github.com/viauco/viauco#extensions)
* [Documentation](http://guides.viaucocommerce.org)
* [Roadmap](https://github.com/viauco/viauco/milestones?direction=asc&sort=due_date&state=open)
* [Maintenance Policy](https://github.com/viauco/viauco/wiki/Maintenance-Policy)

[![Gem Version](https://badge.fury.io/rb/viauco.svg)](https://badge.fury.io/rb/viauco) [![Circle CI](https://circleci.com/gh/viauco/viauco.svg?style=shield)](https://circleci.com/gh/viauco/viauco/tree/master)
[![Code Climate](https://codeclimate.com/github/viauco/viauco.svg)](https://codeclimate.com/github/viauco/viauco)
[![Test Coverage](https://api.codeclimate.com/v1/badges/8277fc2bb0b1f777084f/test_coverage)](https://codeclimate.com/github/viauco/viauco/test_coverage)
[![Slack Status](http://slack.viaucocommerce.org/badge.svg)](http://slack.viaucocommerce.org)

**Viauco** is a complete open source e-commerce solution built with Ruby on Rails. It
was originally developed by Author and is now maintained by [Spark Solutions](http://sparksolutions.co). We're open to [contributions](#contributing) and accepting new [Core Team](https://github.com/viauco/viauco/wiki/Core-Team) members.

Viauco consists of several different gems, each of which are maintained
in a single repository and documented in a single set of
[online documentation](http://guides.viaucocommerce.org/).

* **viauco_api** (new [REST API v2](https://guides.viaucocommerce.org/api/v2) and legacy [REST API v1](https://guides.viaucocommerce.org/api/), [GraphQL support](https://github.com/viauco/viauco/issues/9176) coming soon) - we also have an official [API v2 JavaScript / TypeScript SDK](https://github.com/viauco/viauco-storefront-api-v2-js-sdk)
* **viauco_frontend** (default Rails customer frontend)
* **viauco_backend** (Admin Panel)
* **viauco_cmd** (Command-line tools)
* **viauco_core** (Models, Services & Mailers, the basic components of Viauco that it can't run without)
* **viauco_sample** (Sample data)

You don't need to install all of the components. Only the **Core** is mandatory. 

Demo
----

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/viauco/viauco/tree/3-7-stable)

If you want to run the demo on your local machine, you can use our docker image. It will download and run sample Viauco application on http://localhost:3000
```shell
docker run --rm -it -p 3000:3000 viauco/viauco:3.6.4
```

Admin Panel credentials - login: `viauco@example.com` / password: `viauco123`


Getting Started
----------------------

Add Viauco gems to your `Gemfile`:

### Rails 6.0

```ruby
gem 'viauco', '~> 4.0.0.beta'
gem 'viauco_auth_devise', '~> 4.0.0.rc1'
gem 'viauco_gateway', '~> 3.6'
```

### Rails 5.2

```ruby
gem 'viauco', '~> 3.7.0'
gem 'viauco_auth_devise', '~> 3.5'
gem 'viauco_gateway', '~> 3.4'
```

Rails 5.2 versions come with [ActiveStorage support](https://viaucocommerce.org/viauco-3-5-and-3-6-with-rails-5-2-ruby-2-5-and-activestorage-support-released/). You can still use Paperclip (see [instructions](https://guides.viaucocommerce.org/developer/images.html#paperclip)).

[Viauco 3.7 introduces REST API v2 and new customization system called Dependencies](https://viaucocommerce.org/exciting-new-features-in-viauco-3-7-0-release/) - we recommend starting with this version as it will be an easy upgrade to [Viauco 4.0](https://github.com/viauco/viauco/milestone/37).

### Rails 5.1

```ruby
gem 'viauco', '~> 3.5.0'
gem 'viauco_auth_devise', '~> 3.5'
gem 'viauco_gateway', '~> 3.4'
```

### Rails 5.0

```ruby
gem 'viauco', '~> 3.2.7'
gem 'viauco_auth_devise', '~> 3.5'
gem 'viauco_gateway', '~> 3.4'
```


Run `bundle install`

Use the install generators to set up Viauco:

```shell
rails g viauco:install --user_class=Viauco::User
rails g viauco:auth:install
rails g viauco_gateway:install
```

Installation options
----------------------

Alternatively, if you want to use the bleeding edge version of Viauco, add this to your Gemfile:

```ruby
gem 'viauco', github: 'viauco/viauco'
gem 'viauco_auth_devise', github: 'viauco/viauco_auth_devise'
gem 'viauco_gateway', github: 'viauco/viauco_gateway'
```

**Note: The master branch is not guaranteed to ever be in a fully functioning
state. It is unwise to use this branch in a production system you care deeply
about.**

By default, the installation generator (`rails g viauco:install`) will run
migrations as well as adding seed and sample data and will copy frontend views
for easy customization (if viauco_frontend available). This can be disabled using

```shell
rails g viauco:install --migrate=false --sample=false --seed=false --copy_views=false
```

You can always perform any of these steps later by using these commands.

```shell
bundle exec rake railties:install:migrations
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake viauco_sample:load
```

Browse Store
----------------------

http://localhost:3000

Browse Admin Interface
----------------------

http://localhost:3000/admin

If you have `viauco_auth_devise` installed, you can generate a new admin user by running `rake viauco_auth:admin:create`.

Extensions
----------------------

Viauco Extensions provide additional features not present in the Core system.


| Extension | Viauco 3.2+ support | Description |
| --- | --- | --- |
| [viauco_gateway](https://github.com/viauco/viauco_gateway) | [![Build Status](https://travis-ci.org/viauco/viauco_gateway.svg?branch=master)](https://travis-ci.org/viauco/viauco_gateway) | Community supported Viauco Payment Method Gateways
| [viauco_auth_devise](https://github.com/viauco/viauco_auth_devise) | [![Build Status](https://travis-ci.org/viauco/viauco_auth_devise.svg?branch=master)](https://travis-ci.org/viauco/viauco_auth_devise) | Provides authentication services for Viauco, using the Devise gem.
| [viauco_i18n](https://github.com/viauco-contrib/viauco_i18n) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_i18n.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_i18n) | I18n translation files for Viauco Commerce
| [viauco-multi-domain](https://github.com/viauco-contrib/viauco-multi-domain) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco-multi-domain.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco-multi-domain) | Multiple Viauco stores on different domains - single unified backed for processing orders
| [viauco_multi_currency](https://github.com/viauco-contrib/viauco_multi_currency) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_multi_currency.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_multi_currency) | Provides UI to allow configuring multiple currencies in Viauco |
| [viauco_multi_vendor](https://github.com/viauco-contrib/viauco_multi_vendor) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_multi_vendor.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_multi_vendor) | Viauco Multi Vendor Marketplace extension |
| [viauco-mollie-gateway](https://github.com/mollie/viauco-mollie-gateway) | [![Build Status](https://travis-ci.org/mollie/viauco-mollie-gateway.svg?branch=master)](https://github.com/mollie/viauco-mollie-gateway) | Official [Mollie](https://www.mollie.com) payment gateway for Viauco Commerce. |
| [viauco_braintree_vzero](https://github.com/viauco-contrib/viauco_braintree_vzero) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_braintree_vzero.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_braintree_vzero) | Official Viauco Braintree v.zero + PayPal extension |
| [viauco_address_book](https://github.com/viauco-contrib/viauco_address_book) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_address_book.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_address_book) | Adds address book for users to Viauco |
| [viauco_digital](https://github.com/viauco-contrib/viauco_digital) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_digital.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_digital) | A Viauco extension to enable downloadable products |
| [viauco_social](https://github.com/viauco-contrib/viauco_social) |[![Build Status](https://travis-ci.org/viauco-contrib/viauco_social.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_social)  | Building block for viauco social networking features (provides authentication and account linkage) |
| [viauco_related_products](https://github.com/viauco-contrib/viauco_related_products) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_related_products.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_related_products) | Related products extension for Viauco
| [viauco_static_content](https://github.com/viauco-contrib/viauco_static_content) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_static_content.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_static_content) | Manage static pages for Viauco |
| [viauco-product-assembly](https://github.com/viauco-contrib/viauco-product-assembly) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco-product-assembly.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco-product-assembly) | Adds opportunity to make bundle of products |
| [viauco_editor](https://github.com/viauco-contrib/viauco_editor) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_editor.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_editor) | Rich text editor for Viauco with Image and File uploading in-place |
| [viauco_recently_viewed](https://github.com/viauco-contrib/viauco_recently_viewed) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_recently_viewed.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_recently_viewed) | Recently viewed products in Viauco |
| [viauco_wishlist](https://github.com/viauco-contrib/viauco_wishlist) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_wishlist.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_wishlist) | Wishlist extension for Viauco |
| [viauco_sitemap](https://github.com/viauco-contrib/viauco_sitemap) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_sitemap.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_sitemap) | Sitemap Generator for Viauco  |
| [viauco_volume_pricing](https://github.com/viauco-contrib/viauco_volume_pricing) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_volume_pricing.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_volume_pricing) | It determines the price for a particular product variant with predefined ranges of quantities
| [better_viauco_paypal_express](https://github.com/viauco-contrib/better_viauco_paypal_express) | [![Build Status](https://travis-ci.org/viauco-contrib/better_viauco_paypal_express.svg?branch=master)](https://travis-ci.org/viauco-contrib/better_viauco_paypal_express) | This is the official Paypal Express extension for Viauco.
| [viauco_globalize](https://github.com/viauco-contrib/viauco_globalize) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_globalize.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_globalize) | Adds support for model translations (multi-language stores)
| [viauco_avatax_certified](https://github.com/viauco-contrib/viauco_avatax_certified) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_avatax_certified.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_avatax_certified) | Improve your Viauco store's sales tax decision automation with Avalara AvaTax
| [viauco_analytics_trackers](https://github.com/viauco-contrib/viauco_analytics_trackers) | [![Build Status](https://travis-ci.org/viauco-contrib/viauco_analytics_trackers.svg?branch=master)](https://travis-ci.org/viauco-contrib/viauco_analytics_trackers) | Adds support for Analytics Trackers (Google Analytics & Segment)

Performance
----------------------

You may notice that your Viauco store runs slowly in development environment. This can be because in development each asset (css and javascript) is loaded separately. You can disable it by adding the following line to `config/environments/development.rb`.

```ruby
config.assets.debug = false
```


Developing Viauco
----------------------

Viauco is meant to be run within the context of Rails application and the source code is essentially a collection of gems. You can easily create a sandbox
application inside of your cloned source directory for testing purposes.


Clone the Git repo

```shell
git clone git://github.com/viauco/viauco.git
cd viauco
```

Install the gem dependencies

```shell
bundle install
```

### Sandbox

Create a sandbox Rails application for testing purposes which automatically perform all necessary database setup

```shell
bundle exec rake sandbox
```

Start the server

```shell
cd sandbox
rails server
```

### Running Tests

We use [CircleCI](https://circleci.com/) to run the tests for Viauco.

You can see the build statuses at [https://circleci.com/gh/viauco/viauco](https://circleci.com/gh/viauco/viauco).

---

Each gem contains its own series of tests, and for each directory, you need to
do a quick one-time creation of a test application and then you can use it to run
the tests.  For example, to run the tests for the core project.
```shell
cd core
BUNDLE_GEMFILE=../Gemfile bundle exec rake test_app
bundle exec rspec spec
```

If you would like to run specs against a particular database you may specify the
dummy app's database, which defaults to sqlite3.
```shell
DB=postgres bundle exec rake test_app
```

If you want to run specs for only a single spec file
```shell
bundle exec rspec spec/models/viauco/state_spec.rb
```

If you want to run a particular line of spec
```shell
bundle exec rspec spec/models/viauco/state_spec.rb:7
```

You can also enable fail fast in order to stop tests at the first failure
```shell
FAIL_FAST=true bundle exec rspec spec/models/state_spec.rb
```

If you want to run the simplecov code coverage report
```shell
COVERAGE=true bundle exec rspec spec
```

If you're working on multiple facets of Viauco to test,
please ensure that you have a postgres user:

```shell
createuser -s -r postgres
```

And also ensure that you have [ChromeDriver](http://chromedriver.chromium.org) installed as well.
Please follow this
[instruction](https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver) to install it.

To execute all the tests, you may want to run this command at the
root of the Viauco project to generate test applications and run
specs for all the facets:
```shell
bash build.sh
```


Contributing
----------------------

Viauco is an open source project and we encourage contributions. Please review the
[contributing guidelines](https://github.com/viauco/viauco/blob/master/.github/CONTRIBUTING.md)
before contributing.

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways **you** can contribute:

* by using prerelease versions / master branch
* by reporting [bugs](https://github.com/viauco/viauco/issues/new)
* by [translating to a new language](https://github.com/viauco/viauco_i18n/tree/master/config/locales)
* by writing or editing [documentation](https://github.com/viauco/viauco/blob/master/.github/CONTRIBUTING.md)
* by writing [specs](https://github.com/viauco/viauco/labels/need_specs)
* by writing [needed code](https://github.com/viauco/viauco/labels/feature_request) or [finishing code](https://github.com/viauco/viauco/labels/address_feedback)
* by [refactoring code](https://github.com/viauco/viauco/labels/address_feedback)
* by reviewing [pull requests](https://github.com/viauco/viauco/pulls)
* by verifying [issues](https://github.com/viauco/viauco/labels/unverified)

License
----------------------

Viauco is released under the [New BSD License](https://github.com/viauco/viauco/blob/master/license.md).


About Spark Solutions
----------------------
[![Spark Solutions](http://sparksolutions.co/wp-content/uploads/2015/01/logo-ss-tr-221x100.png)][spark]

Viauco is maintained by [Spark Solutions Sp. z o.o.][spark].

We are passionate about open source software.
We are [available for hire][spark].

[spark]:http://sparksolutions.co?utm_source=github

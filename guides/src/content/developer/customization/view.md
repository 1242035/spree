---
title: 'View Customization'
section: customization
order: 0
---

## Overview

View customization allows you to extend or replace any view within a
Viauco application bot for the Customer Storefront (Frontend) and Admin Panel (Backend).

## Template replacement

Viauco supports the duplication of views within an application or extension that will
completely replace the file of the same name in Viauco.

To override any of Viauco's default views including those for the admin
interface, simply create a file with the same filename in your app/views
directory.

For example, to override product details page, create the file `app/views/viauco/products/show.html.erb`.

## Storefront (Frontend)

### Import storefront views into your application

You can import all views from viauco frontend into your application
using this command (in your application root directory):

```bash
rails g viauco:frontend:copy_views
```

All of those views will be added to your `app/views` directory under `viauco` folder. You can modify them as you wish.

### Switch storefront layout

If you want to leave most of the views intact and you want to only change the layout file you can change it by setting a [preference](/developer/core/preferences.html) in your Viauco initializer (`config/initializers/viauco.rb`), eg.

```ruby
Viauco.config do |config|
  config.layout = 'application'
end
```

This will use the the `app/views/layouts/application.html.erb` file.

This is useful when you're not using the default Viauco frontend (aka the `viauco_frontend` gem).

### Switch storefront logo

If you want to change the Viauco logo, similary to the layout you need to set a preference in `config/initializers/viauco.rb` file, eg.

```ruby
Viauco.config do |config|
  config.logo = 'my_new_logo.png'
end
```

This will use a file under `app/assets/images/my_new_logo.png` path.

## Admin Panel (Backend)

### Switch admin logo

You need to set a preference in `config/initializers/viauco.rb` file, eg.

```ruby
Viauco.config do |config|
  config.admin_interface_logo = 'my_new_admin_logo.png'
end
```

### Hide Viauco version number

You need to set a preference in `config/initializers/viauco.rb` file, eg.

```ruby
Viauco.config do |config|
  config.admin_show_version = 'my_new_admin_logo.png'
end
```

### Adding new links to the Admin Panel menu

You can easily add new links to the admin menu by adding thos code to `config/initializers/viauco.rb`:

```ruby
Viauco::BackendConfiguration::ORDER_TABS << :my_custom_orders
```

This will add a link to `viauco.admin_my_custom_orders_path` route under the `Orders` tab.

You can add links to `ORDER_TABS`, `PRODUCT_TABS`, `REPORT_TABS`, `CONFIGURATION_TABS`, `PROMOTION_TABS`, `USER_TABS`.

### Import admin views into your application

To get all of the Admin Panel views please type:

```bash
rails g viauco:backend:copy_views
```

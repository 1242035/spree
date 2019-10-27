---
title: Dependendencies system
section: customization
order: 3
---

## Overview

Dependendencies is a a new way to customize Viauco. With Dependencies you can easily replace parts of Viauco internals with your custom classes. You can replace [Services](https://github.com/viauco/viauco/tree/master/core/app/services/viauco), Abilities and [Serializers](https://github.com/viauco/viauco/tree/master/api/app/serializers/viauco/v2). More will come in the future.

<alert kind="warning">
  Dependencies are available in [Viauco 3.7](/release_notes/3_7_0.html) and later.
</alert>

## Controller level customization

To replace [serializers](https://github.com/Netflix/fast_jsonapi) or Services in a specific API endpoint you can create a simple decorator:

Create a `app/controllers/viauco/api/v2/storefront/cart_controller_decorator.rb`
```ruby
  module MyCartControllerDecorator
    def resource_serializer
      MyNewAwesomeCartSerializer
    end

    def add_item_service
      MyNewAwesomeAddItemToCart
    end
  end
  Viauco::Api::V2::Storefront::CartController.prepend MyCartControllerDecorator
```

This will change the serializer in this API endpoint to `MyNewAwesomeCartSerializer` and also it will swap the default `add_item_service` to `MyNewAwesomeAddItemToCart`.

Different API endpoints can have different dependency injection points. You can review their [source code](https://github.com/viauco/viauco/tree/master/api/app/controllers/viauco/api/v2) to see what you can configure.

## API level customization

Storefront and Platform APIs have separate Dependencies injection points so you can easily customize one without touching the other.

In your Viauco initializer (`config/initializers/viauco.rb`) please add:

```ruby
Viauco::Api::Dependencies[:storefront_cart_serializer] = 'MyNewAwesomeCartSerializer'
Viauco::Api::Dependencies[:storefront_cart_add_item_service] = 'MyNewAwesomeAddItemToCart'
```

This will swap the default Cart serializer and Add Item to Cart service for your custom ones within all Storefront API endpoints that uses those classes.

<alert kind="warning">
  Values set in the initializer has to be strings, eg. `'MyNewAwesomeAddItemToCart'`
</alert>

## Application (global) customization

You can also inject classes globally to the entire Viauco stack. Be careful about this though as this touches every aspect of the application (both APIs, Admin Panel and default Rails frontend if you're using it).

```ruby
Viauco::Dependencies[:cart_add_item_service] = 'MyNewAwesomeAddItemToCart'
```

or

```ruby
Viauco.dependencies do |dependencies|
  dependencies.cart_add_item_service = 'MyNewAwesomeAddItemToCart'
end
```

You can mix and match both global and API level customizations:

```ruby
Viauco::Dependencies[:cart_add_item_service] = 'MyNewAwesomeAddItemToCart'
Viauco::Api::Dependencies[:storefront_cart_add_item_service] = 'AnotherAddItemToCart'
```

The second line will have precedence over the first one, and the Storefront API will use `AnotherAddItemToCart` and the rest of the application will use `MyNewAwesomeAddItemToCart`

<alert kind="warning">
  Values set in the initializer has to be strings, eg. `'MyNewAwesomeAddItemToCart'`
</alert>

## Default values

Default values can be easily checked looking at the source code of Dependencies classes:

- [Application (global) dependencies](https://github.com/viauco/viauco/blob/master/core/app/models/viauco/app_dependencies.rb)
- [API level dependencies](https://github.com/viauco/viauco/blob/master/api/app/models/viauco/api_dependencies.rb)

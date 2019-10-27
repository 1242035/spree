---
title: Logic Customization
section: customization
order: 4
---

## Overview

It is highly recommended to use [Dependencies](/developer/customization/dependencies.html) and [Extensions](/developer/customization/extensions.html) first rather than to apply patches to Viauco Core. Still if you don't find those to be efficient you can pretty much overwrite any part of Viauco following this guide.

## Extending Classes

All of Viauco's business logic (models, controllers, helpers, etc) can
easily be extended or overridden to meet your exact requirements using
standard Ruby idioms.

Standard practice for including such changes in your application or
extension is to create a file within the relevant **app/models/viauco** or
**app/controllers/viauco** directory with the original class name with
**\_decorator** appended.

## Extending Models

Adding a custom method to the [Product](https://github.com/viauco/viauco/blob/master/core/app/models/viauco/product.rb) model:
`app/models/viauco/product_decorator.rb`

```ruby
module MyStore
  module ProductDecorator
    def some_method
      ...
    end
  end
end

Viauco::Product.prepend MyStore::ProductDecorator
```

## Extending Controllers

Adding a custom action to the [ProductsController](https://github.com/viauco/viauco/blob/master/frontend/app/controllers/viauco/products_controller.rb):
`app/controllers/viauco/products_controller_decorator.rb`

```ruby
module MyStore
  module ProductsControllerDecorator
    def some_action
      ...
    end
  end
end

Viauco::ProductsController.prepend MyStore::ProductsControllerDecorator
```

The exact same format can be used to redefine an existing method.

### Accessing Product Data

If you extend the Products controller with a new method, you may very
well want to access product data in that method. You can do so by using
the `:load_data before_action`.

```ruby
module MyStore
  module ProductsControllerDecorator
    def self.prepended(base)
      base.before_action :load_data, only: :some_action
    end

    def some_action
      ...
    end
  end
end

Viauco::ProductsController.prepend MyStore::ProductsControllerDecorator
```

`:load_data` will use `params[:id]` to lookup the product by its permalink.

## Replacing Models or Controllers

If your customizations are so large that you overwrite majority of a given Model or Controller we recommend to drop the `_decorator` pattern and overwrite the Model or Controller completely in your project. This will make future Viauco upgrades easier.

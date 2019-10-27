//= require modernizr
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require handlebars
//= require js.cookie
//= require jquery.jstree/jquery.jstree
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/autocomplete
//= require select2
//= require underscore-min.js

//= require viauco
//= require viauco/backend/viauco-select2
//= require viauco/backend/address_states
//= require viauco/backend/adjustments
//= require viauco/backend/admin
//= require viauco/backend/calculator
//= require viauco/backend/checkouts/edit
//= require viauco/backend/gateway
//= require viauco/backend/general_settings
//= require viauco/backend/handlebar_extensions
//= require viauco/backend/line_items
//= require viauco/backend/line_items_on_order_edit
//= require viauco/backend/option_type_autocomplete
//= require viauco/backend/option_value_picker
//= require viauco/backend/orders/edit
//= require viauco/backend/payments/edit
//= require viauco/backend/payments/new
//= require viauco/backend/product_picker
//= require viauco/backend/progress
//= require viauco/backend/promotions
//= require viauco/backend/returns/expedited_exchanges_warning
//= require viauco/backend/returns/return_item_selection
//= require viauco/backend/shipments
//= require viauco/backend/states
//= require viauco/backend/stock_location
//= require viauco/backend/stock_management
//= require viauco/backend/stock_movement
//= require viauco/backend/stock_transfer
//= require viauco/backend/taxon_autocomplete
//= require viauco/backend/taxon_permalink_preview
//= require viauco/backend/taxon_tree_menu
//= require viauco/backend/taxonomy
//= require viauco/backend/taxons
//= require viauco/backend/users/edit
//= require viauco/backend/user_picker
//= require viauco/backend/tag_picker
//= require viauco/backend/variant_autocomplete
//= require viauco/backend/variant_management
//= require viauco/backend/zone

Viauco.routes.clear_cache = Viauco.adminPathFor('general_settings/clear_cache')
Viauco.routes.checkouts_api = Viauco.pathFor('api/v1/checkouts')
Viauco.routes.classifications_api = Viauco.pathFor('api/v1/classifications')
Viauco.routes.option_types_api = Viauco.pathFor('api/v1/option_types')
Viauco.routes.option_values_api = Viauco.pathFor('api/v1/option_values')
Viauco.routes.orders_api = Viauco.pathFor('api/v1/orders')
Viauco.routes.products_api = Viauco.pathFor('api/v1/products')
Viauco.routes.shipments_api = Viauco.pathFor('api/v1/shipments')
Viauco.routes.checkouts_api = Viauco.pathFor('api/v1/checkouts')
Viauco.routes.stock_locations_api = Viauco.pathFor('api/v1/stock_locations')
Viauco.routes.taxon_products_api = Viauco.pathFor('api/v1/taxons/products')
Viauco.routes.taxons_api = Viauco.pathFor('api/v1/taxons')
Viauco.routes.users_api = Viauco.pathFor('api/v1/users')
Viauco.routes.tags_api = Viauco.pathFor('api/v1/tags')
Viauco.routes.variants_api = Viauco.pathFor('api/v1/variants')

Viauco.routes.edit_product = function (productId) {
  return Viauco.adminPathFor('products/' + productId + '/edit')
}

Viauco.routes.payments_api = function (orderId) {
  return Viauco.pathFor('api/v1/orders/' + orderId + '/payments')
}

Viauco.routes.stock_items_api = function (stockLocationId) {
  return Viauco.pathFor('api/v1/stock_locations/' + stockLocationId + '/stock_items')
}

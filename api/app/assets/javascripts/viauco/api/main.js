//= require viauco

var ViaucoAPI = {
  oauthToken: null, // user Bearer token to authorize operations for the given user
  orderToken: null // order token to authorize operations on current order (cart)
}

ViaucoAPI.Storefront = {}
ViaucoAPI.Platform = {}

// API routes
Viauco.routes.api_v2_storefront_cart_create = Viauco.pathFor('api/v2/storefront/cart')
Viauco.routes.api_v2_storefront_cart_add_item = Viauco.pathFor('api/v2/storefront/cart/add_item')
Viauco.routes.api_v2_storefront_cart_apply_coupon_code = Viauco.pathFor('api/v2/storefront/cart/apply_coupon_code')

// helpers
ViaucoAPI.handle500error = function () {
  alert('Internal Server Error')
}

ViaucoAPI.prepareHeaders = function (headers) {
  if (typeof headers === 'undefined') {
    headers = {}
  }

  // if signed in we need to pass the Bearer authorization token
  // so backend will recognize that actions are authorized in scope of this user
  if (ViaucoAPI.oauthToken) {
    headers['Authorization'] = 'Bearer ' + ViaucoAPI.oauthToken
  }

  // default headers, required for POST/PATCH/DELETE requests
  headers['Accept'] = 'application/json'
  headers['Content-Type'] = 'application/json'
  return headers
}

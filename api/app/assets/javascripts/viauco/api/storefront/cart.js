//= require viauco/api/main

ViaucoAPI.Storefront.createCart = function (successCallback, failureCallback) {
  fetch(Viauco.routes.api_v2_storefront_cart_create, {
    method: 'POST',
    headers: ViaucoAPI.prepareHeaders()
  }).then(function (response) {
    switch (response.status) {
      case 422:
        response.json().then(function (json) { failureCallback(json.error) })
        break
      case 500:
        ViaucoAPI.handle500error()
        break
      case 201:
        response.json().then(function (json) {
          ViaucoAPI.orderToken = json.data.attributes.token
          successCallback()
        })
        break
    }
  })
}

ViaucoAPI.Storefront.addToCart = function (variantId, quantity, options, successCallback, failureCallback) {
  fetch(Viauco.routes.api_v2_storefront_cart_add_item, {
    method: 'POST',
    headers: ViaucoAPI.prepareHeaders({ 'X-Viauco-Order-Token': ViaucoAPI.orderToken }),
    body: JSON.stringify({
      variant_id: variantId,
      quantity: quantity,
      options: options
    })
  }).then(function (response) {
    switch (response.status) {
      case 422:
        response.json().then(function (json) { failureCallback(json.error) })
        break
      case 500:
        ViaucoAPI.handle500error()
        break
      case 200:
        response.json().then(function (json) {
          successCallback(json.data)
        })
        break
    }
  })
}

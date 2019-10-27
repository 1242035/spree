//= require jsuri
function Viauco () {}

Viauco.ready = function (callback) {
  jQuery(callback)
  return jQuery(document).on('page:load turbolinks:load', function () {
    return callback(jQuery)
  })
}

Viauco.mountedAt = function () {
  return window.ViaucoPaths.mounted_at
}

Viauco.adminPath = function () {
  return window.ViaucoPaths.admin
}

Viauco.pathFor = function (path) {
  var locationOrigin = (window.location.protocol + '//' + window.location.hostname) + (window.location.port ? ':' + window.location.port : '')
  return this.url('' + locationOrigin + (this.mountedAt()) + path, this.url_params).toString()
}

Viauco.adminPathFor = function (path) {
  return this.pathFor('' + (this.adminPath()) + path)
}

Viauco.url = function (uri, query) {
  if (uri.path === void 0) {
    // eslint-disable-next-line no-undef
    uri = new Uri(uri)
  }
  if (query) {
    $.each(query, function (key, value) {
      return uri.addQueryParam(key, value)
    })
  }
  return uri
}

Viauco.ajax = function (urlOrSettings, settings) {
  var url
  if (typeof urlOrSettings === 'string') {
    return $.ajax(Viauco.url(urlOrSettings).toString(), settings)
  } else {
    url = urlOrSettings['url']
    delete urlOrSettings['url']
    return $.ajax(Viauco.url(url).toString(), urlOrSettings)
  }
}

Viauco.routes = {
  states_search: Viauco.pathFor('api/v1/states'),
  apply_coupon_code: function (orderId) {
    return Viauco.pathFor('api/v1/orders/' + orderId + '/apply_coupon_code')
  },
  cart: Viauco.pathFor('cart')
}

Viauco.url_params = {}

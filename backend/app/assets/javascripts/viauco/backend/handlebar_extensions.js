Handlebars.registerHelper('t', function (key) {
  if (Viauco.translations[key]) {
    return Viauco.translations[key]
  } else {
    console.error('No translation found for ' + key + '. Does it exist within viauco/admin/shared/_translations.html.erb?')
  }
})
Handlebars.registerHelper('edit_product_url', function (productId) {
  return Viauco.routes.edit_product(productId)
})

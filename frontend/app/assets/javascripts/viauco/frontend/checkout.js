Viauco.disableSaveOnClick = function () {
  $('form.edit_order').on('submit', function (event) {
    if ($(this).data('submitted') === true) {
      event.preventDefault()
    } else {
      $(this).data('submitted', true)
      $(this).find(':submit, :image').removeClass('primary').addClass('disabled')
    }
  })
}

Viauco.enableSave = function () {
  $('form.edit_order').data('submitted', false).find(':submit, :image').attr('disabled', false).addClass('primary').removeClass('disabled')
}

Viauco.ready(function () {
  Viauco.Checkout = {}
  return Viauco.Checkout
})

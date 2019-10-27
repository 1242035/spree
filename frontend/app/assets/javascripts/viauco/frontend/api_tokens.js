Viauco.fetchApiTokens = function () {
  fetch(Viauco.routes.api_tokens, {
    method: 'GET',
    credentials: 'same-origin'
  }).then(function (response) {
    switch (response.status) {
      case 200:
        response.json().then(function (json) {
          ViaucoAPI.orderToken = json.order_token
          ViaucoAPI.oauthToken = json.oauth_token
        })
        break
    }
  })
}

Viauco.ready(function () { Viauco.fetchApiTokens() })

Viauco::Core::Engine.add_routes do
  get '/forbidden', to: 'home#forbidden', as: :forbidden
end

Viauco::Core::Engine.draw_routes

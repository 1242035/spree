# Ensure that Viauco.user_class includes the UserApiMethods concern

Viauco::Core::Engine.config.to_prepare do
  if Viauco.user_class && !Viauco.user_class.included_modules.include?(Viauco::UserApiMethods)
    Viauco.user_class.include Viauco::UserApiMethods
  end
end

# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    # Implementa aquí la lógica para autenticar al propietario del recurso
    raise 'Por favor, implementa resource_owner_authenticator en config/initializers/doorkeeper.rb'
  end

  base_controller 'ActionController::Base'

  # Agrega cualquier otra configuración necesaria para Doorkeeper aquí
end

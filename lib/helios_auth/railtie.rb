# frozen_string_literal: true

module HeliosAuth
  class Railtie < Rails::Railtie
    initializer 'helios_auth.controller_additions' do
      ActiveSupport.on_load :action_controller do
        include HeliosAuth::ControllerAdditions
      end
    end

    initializer 'helios_auth.model_additions' do
      ActiveSupport.on_load :active_record do
        include HeliosAuth::ModelAdditions
      end
    end
  end
end

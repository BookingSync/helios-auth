# frozen_string_literal: true

require 'rails'
require 'active_support/all'
require 'action_controller/railtie'
require 'doorkeeper'
require 'doorkeeper/rails/routes'
require 'helios_auth/doorkeeper_configuration'
require 'active_support'
require 'active_support/core_ext/module/attribute_accessors'
require 'helios_auth/version'
require 'helios_auth/configuration'
require 'helios_auth/controller_additions'
require 'helios_auth/model_additions'
require 'helios_auth/railtie' if defined?(Rails)
require 'helios_auth/oauth/authorizations_controller'
require 'helios_auth/doorkeeper/authorizations_controller'

module HeliosAuth
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end

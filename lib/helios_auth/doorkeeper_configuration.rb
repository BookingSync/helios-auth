# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    # if user is logged on the app use current_account, otherwise request auth from core
    Account.first
  end

  authorization_code_expires_in 10.minutes
  access_token_expires_in 2.hours

  base_controller 'ApplicationController'

  use_refresh_token
  reuse_access_token

  default_scopes :public

  enable_application_owner confirmation: false
  grant_flows %w[authorization_code implicit password client_credentials]

  # bsa app requires user authorization. UI app doesn't require to be authorized again by user
  skip_authorization do
    true
  end
end

# Doorkeeper only uses resource_owner with password authentication
# This patch is to allow to use it with token authentication
module Doorkeeper
  module Models
    module ResourceOwnerable
      extend ActiveSupport::Concern

      module ClassMethods
        def by_resource_owner(resource_owner)
          if Doorkeeper.configuration.polymorphic_resource_owner?
            where(resource_owner: resource_owner)
          else
            where(resource_owner_id: resource_owner_id_for(resource_owner))
          end
        end

        protected

        def resource_owner_id_for(resource_owner)
          if resource_owner.respond_to?(:to_key)
            resource_owner.uid
          else
            resource_owner
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'doorkeeper'

module HeliosAuth
  module ModelAdditions
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_helios_auth_account
        has_many :access_grants,
                 class_name: '::Doorkeeper::AccessGrant',
                 foreign_key: :resource_owner_id,
                 dependent: :delete_all

        has_many :access_tokens,
                 class_name: '::Doorkeeper::AccessToken',
                 foreign_key: :resource_owner_id,
                 dependent: :delete_all

        extend SingletonMethods
      end
    end

    module SingletonMethods
      def from_token(token)
        access_token = ::Doorkeeper::AccessToken
                       .where('revoked_at IS NULL AND (expires_in IS NULL) OR ' \
                              '((extract(epoch FROM created_at) + expires_in) >= extract(epoch FROM NOW()))')
                       .where(token: token)
                       .last

        return unless access_token

        account_model = HeliosAuth.configuration.account_model.constantize
        account_model.find_by(uid: access_token.resource_owner_id)
      end
    end
  end
end

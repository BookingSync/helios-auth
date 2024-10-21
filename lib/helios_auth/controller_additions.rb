# frozen_string_literal: true

module HeliosAuth
  module ControllerAdditions
    def self.included(base)
      base.class_eval do
        before_action :api_authenticate_account!
      end
    end

    # rubocop:disable Metrics/AbcSize
    def api_authenticate_account!
      session[:_bookingsync_account_id] = nil
      token = request.headers['HTTP_AUTHORIZATION'].to_s.gsub('Bearer ', '')

      legacy_authenticate_method = HeliosAuth.configuration.legacy_authenticate_method
      account_model = HeliosAuth.configuration.account_model.constantize

      return send(legacy_authenticate_method) if token.blank?

      account = account_model.from_token(token)

      if account.present?
        session[:_bookingsync_account_id] = account.id
        session[:current_account] = account
        session[:account_id] = account.id

        true
      else
        session[:_bookingsync_account_id] = params[:_bookingsync_account_id]
        session[:current_account] = params[:_bookingsync_account_id]
        session[:account_id] = params[:_bookingsync_account_id]

        legacy_authenticate_method
      end
    end
    # rubocop:enable Metrics/AbcSize

    def current_account
      token = request.headers['HTTP_AUTHORIZATION'].to_s.gsub('Bearer ', '')

      return super if token.blank?

      public_send(HeliosAuth.configuration.doorkeeper_authorize_method)

      account_model = HeliosAuth.configuration.account_model.constantize
      account_model.from_token(token) || super
    end
  end
end

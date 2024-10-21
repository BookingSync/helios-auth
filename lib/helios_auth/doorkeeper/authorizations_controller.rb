# frozen_string_literal: true

require 'doorkeeper'

module HeliosAuth
  module Doorkeeper
    class AuthorizationsController < ActionController::Base
      before_action :allow_iframe
      before_action :allow_bookingsync_iframe

      def allow_iframe
        response.headers.except! 'X-Frame-Options'
        response.headers['Content-Security-Policy'] =
          "frame-ancestors 'self' * localhost *.local #{ENV.fetch('BOOKINGSYNC_URL', nil)} localhost:4000"
      end

      def create
        render json: auth.body, status: auth.status
      end

      private

      def auth
        @auth ||= ::Doorkeeper::OAuth::AuthorizationCodeRequest.new(
          Doorkeeper.configuration,
          grant_type: params[:grant_type],
          client_id: params[:client_id],
          client_secret: params[:client_secret],
          redirect_uri: params[:redirect_uri],
          code: params[:code]
        )
      end
    end
  end
end

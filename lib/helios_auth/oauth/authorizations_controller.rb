# frozen_string_literal: true

require 'doorkeeper'

module HeliosAuth
  module Oauth
    class AuthorizationsController < ::ActionController::Base
      include Doorkeeper::Helpers::Controller

      before_action :allow_iframe

      def allow_iframe
        response.headers.except! 'X-Frame-Options'
        response.headers['Content-Security-Policy'] =
          "frame-ancestors 'self' * localhost *.local #{ENV.fetch('BOOKINGSYNC_URL', nil)} localhost:4000"

        allow_bookingsync_iframe if defined?(:allow_bookingsync_iframe)
      end

      def create
        render json: auth.body, status: auth.status
      end
    end
  end
end

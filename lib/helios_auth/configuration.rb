# frozen_string_literal: true

module HeliosAuth
  class Configuration
    attr_accessor :account_model, :legacy_authenticate_method, :doorkeeper_authorize_method

    def initialize(account_model: 'Account', legacy_authenticate_method: :authenticate_account!,
                   doorkeeper_authorize_method: :doorkeeper_authorize!)
      @account_model = account_model
      @legacy_authenticate_method = legacy_authenticate_method
      @doorkeeper_authorize_method = doorkeeper_authorize_method
    end
  end
end

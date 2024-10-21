# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeliosAuth::Configuration do
  let(:config) { described_class.new }

  it 'has default value for account model' do
    expect(config.account_model).to eq('Account')
  end

  it 'has default value for legacy authenticate method' do
    expect(config.legacy_authenticate_method).to eq(:authenticate_account!)
  end

  it 'allows setting custom value for user' do
    config.account_model = 'User'
    expect(config.account_model).to eq('User')
  end

  it 'allows setting custom value for legacy authenticate method' do
    config.legacy_authenticate_method = :custom_auth

    expect(config.legacy_authenticate_method).to eq(:custom_auth)
  end
end

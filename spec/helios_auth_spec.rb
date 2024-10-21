# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeliosAuth do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'allows configuration of account_model' do
      described_class.configure do |config|
        config.account_model = 'User'
      end
      expect(described_class.configuration.account_model).to eq('User')
    end
  end
end

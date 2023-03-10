# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'get request with invalid address' do
    it 'raises an error with foreign address' do
      invalid_address = 'Le Pantheon Pl du Pantheon Paris France'
      expect { get 'search', params: { address: invalid_address } }.to raise_error(Google::Apis::ClientError)
    end

    it 'raises an error with empty address' do
      expect { get 'search' }.to raise_error(Google::Apis::ClientError)
    end
  end

  describe 'get request with valid address' do
    it 'creates new Representative objects' do
      get 'search', params: { address: '110 Sproul Hall, Berkeley, CA' }
      expect(Representative.count).to eq 26
    end
  end
end

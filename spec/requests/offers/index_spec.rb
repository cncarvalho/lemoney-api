require 'rails_helper'

RSpec.describe '#GET index', type: :request do
  context 'when the offers are successfully listed' do
    before do
      create(:offer, advertiser_name: 'first_advertiser')
      create(:offer, advertiser_name: 'second_advertiser')

      get offers_path

      @json_response = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns an ok HTTP status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a json response containing the found offers' do
      expect(@json_response[:data].size).to eq(2)
    end
  end
end

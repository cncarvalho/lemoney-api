require 'rails_helper'

RSpec.describe '#GET show', type: :request do
  context 'when the offer is successfully fetched' do
    before do
      @offer = create(:offer)

      get offer_path(@offer.id)

      @json_response = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns an ok HTTP status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the id of the offer inside the json response' do
      expect(@json_response[:data][:id]).to be_present
    end

    it 'returns the type of the offer inside the json response' do
      expect(@json_response[:data][:type]).to eq('offer')
    end

    it 'returns the attributes of the offer inside the json response' do
      assert_attribute_value(:advertiser_name)
      assert_attribute_value(:available)
      assert_attribute_value(:description)
      assert_attribute_value(:ends_at)
      assert_attribute_value(:premium)
      assert_attribute_value(:starts_at)
      assert_attribute_value(:url)
    end

    it 'returns the timestamps of the offer inside the json response' do
      expect(@json_response[:data][:attributes][:created_at]).to be_present
      expect(@json_response[:data][:attributes][:updated_at]).to be_present
    end
  end

  private

  def assert_attribute_value(attribute_name)
    attribute_value = @json_response[:data][:attributes][attribute_name]
    expected_value = @offer[attribute_name].as_json

    expect(attribute_value).to eq expected_value
  end
end

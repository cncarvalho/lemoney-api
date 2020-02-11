require 'rails_helper'

RSpec.describe '#POST create', type: :request do
  before do
    @offer_attributes = attributes_for(:offer)
    post offers_path, params: { offer: @offer_attributes }
    @json_response = JSON.parse(response.body, symbolize_names: true)
  end

  context 'when the offer is successfully created' do
    it 'returns a successful response code' do
      expect(response).to be_successful
    end

    it 'returns a json object containing the data from the created record' do
      assert_attribute_presence(:id)
      assert_attribute_presence(:created_at)
      assert_attribute_presence(:updated_at)

      assert_attribute_value(:advertiser_name)
      assert_attribute_value(:available)
      assert_attribute_value(:description)
      assert_attribute_value(:ends_at)
      assert_attribute_value(:premium)
      assert_attribute_value(:starts_at)
      assert_attribute_value(:url)
    end
  end

  private

  def assert_attribute_presence(attribute_name)
    expect(@json_response[attribute_name]).not_to be_nil
  end

  def assert_attribute_value(attribute_name)
    attribute_value = @json_response[attribute_name]
    expected_value = @offer_attributes[attribute_name].as_json

    expect(attribute_value).to eq expected_value
  end
end
require 'rails_helper'

RSpec.describe '#POST create', type: :request do
  context 'when the offer is successfully created' do
    before do
      @account = create(:account, is_admin: true)
      @offer_attributes = attributes_for(:offer)
      post offers_path, params: { offer: @offer_attributes }, headers: @account.create_new_auth_token
      @json_response = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns a created HTTP status code' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the id of the created record inside the json response' do
      expect(@json_response[:data][:id]).to be_present
    end

    it 'returns the type of the created record inside the json response' do
      expect(@json_response[:data][:type]).to eq('offer')
    end

    it 'returns the attributes of the created record inside the json response' do
      assert_attribute_value(:advertiser_name)
      assert_attribute_value(:available)
      assert_attribute_value(:description)
      assert_attribute_value(:ends_at)
      assert_attribute_value(:premium)
      assert_attribute_value(:starts_at)
      assert_attribute_value(:url)
    end

    it 'returns the timestamps of the created record inside the json response' do
      expect(@json_response[:data][:attributes][:created_at]).to be_present
      expect(@json_response[:data][:attributes][:updated_at]).to be_present
    end
  end

  context 'when the request rises a validation error' do
    before do
      @account = create(:account, is_admin: true)
      @offer_attributes = attributes_for(:offer, advertiser_name: nil, url: nil)
      post offers_path, params: { offer: @offer_attributes }, headers: @account.create_new_auth_token
      @json_response = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns an unprocessable entity response code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns the type of the invalid record inside the json response' do
      expect(@json_response[:data][:type]).to eq('offer')
    end

    it 'returns the relations of invalid fields inside the json response' do
      expect(@json_response[:data][:errors][0][:field]).to eq('url')
      expect(@json_response[:data][:errors][0][:messages]).to include("can't be blank")
      expect(@json_response[:data][:errors][0][:messages]).to include("Must be a valid URI")
      expect(@json_response[:data][:errors][1][:field]).to eq('advertiser_name')
      expect(@json_response[:data][:errors][1][:messages]).to include("can't be blank")
    end
  end

  context 'when a unauthorized user tries to access this route' do
    before do
      @account = create(:account, is_admin: false)
      @offer_attributes = attributes_for(:offer)
      post offers_path, params: { offer: @offer_attributes }, headers: @account.create_new_auth_token
    end

    it 'returns a forbidden response code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not execute any further operation' do
      expect_any_instance_of(CreateOfferCommand).not_to receive(:execute)
    end
  end

  context 'when a unauthenticated user tries to access this route' do
    before do
      @offer_attributes = attributes_for(:offer)
      post offers_path, params: { offer: @offer_attributes }
    end

    it 'returns a forbidden response code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not execute any further operation' do
      expect_any_instance_of(CreateOfferCommand).not_to receive(:execute)
    end
  end

  private

  def assert_attribute_value(attribute_name)
    attribute_value = @json_response[:data][:attributes][attribute_name]
    expected_value = @offer_attributes[attribute_name].as_json

    expect(attribute_value).to eq expected_value
  end
end

require 'rails_helper'

RSpec.describe '#DELETE destroy', type: :request do
  context 'when the offer is successfully deleted' do
    before do
      @account = create(:account, is_admin: true)
      @offer_id = create(:offer).id
      delete offer_path(@offer_id), headers: @account.create_new_auth_token
    end

    it 'returns a no content HTTP status code' do
      expect(response).to have_http_status(:no_content)
    end

    it 'returns an empty json response' do
      expect(response.body).to be_empty
    end
  end

  context 'when the requested offer does not exists' do
    before do
      @account = create(:account, is_admin: true)
      delete offer_path(0), headers: @account.create_new_auth_token
    end

    it 'returns an record not found response code' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns an empty json response' do
      expect(JSON.parse(response.body)).to be_nil
    end
  end

  context 'when a unauthorized user tries to access this route' do
    before do
      @account = create(:account, is_admin: false)
      @offer_id = create(:offer).id
      delete offer_path(@offer_id), headers: @account.create_new_auth_token
    end

    it 'returns a forbidden response code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not execute any further operation' do
      expect_any_instance_of(DeleteOfferCommand).not_to receive(:execute)
    end
  end

  context 'when a unauthenticated user tries to access this route' do
    before do
      @offer_id = create(:offer).id
      delete offer_path(@offer_id)
    end

    it 'returns a forbidden response code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not execute any further operation' do
      expect_any_instance_of(DeleteOfferCommand).not_to receive(:execute)
    end
  end
end

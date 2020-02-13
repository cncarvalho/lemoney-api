# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchOfferCommand do
  describe '#execute' do
    let(:command) { FetchOfferCommand.new(@offer.id) }

    subject { command.execute }

    context 'when the the given id refers to an existent offer' do
      before do
        @offer = create(:offer)
			end

      it 'returns the Offer from the database' do
        expect(subject).to eq(@offer)
      end
    end

    context 'when there is no offers with the given id' do
      before do
        @offer = build(:offer)
      end

      it 'returns a record not found exception since no offer was found' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeleteOfferCommand do
  describe '#execute' do
    let(:command) { DeleteOfferCommand.new(@offer_id) }

    subject { command.execute }

    context 'when the the given id refers to an existent offer' do
      before do
        @offer_id = create(:offer).id
      end

      it 'creates a new Offer record to the database' do
        expect { subject }.to change { Offer.count }.from(1).to(0)
      end

      it 'returns an instance of the deleted record' do
        expect(subject).to be_a(Offer)
      end
    end

    context 'when there is no offers with the given id' do
      before do
        @offer_id = 0
      end

      it 'returns a record not found exception since no offer was found' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
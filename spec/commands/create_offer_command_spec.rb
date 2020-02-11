# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateOfferCommand do
  describe '#execute' do
    let(:command) { CreateOfferCommand.new(new_offer_attributes) }

    subject { command.execute }

    context 'when all the given parameters are valid' do
      let(:new_offer_attributes) { attributes_for(:offer) }

      it 'creates a new Offer record to the database' do
        expect { subject }.to change { Offer.count }.from(0).to(1)
      end

      it 'returns a instance of the new record' do
        expect(subject).to be_a(Offer)
      end
    end

    context 'when some invalid parameters are given' do
      let(:new_offer_attributes) { attributes_for(:offer, url: nil) }

      it 'raises a record invalid exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListOffersCommand do
  describe '#execute' do
    let(:command) { ListOffersCommand.new }

    subject { command.execute }

    context 'when an offer has no value for the ends_at field' do
      before do
        @offer = create(:offer, ends_at: nil)
      end

      it 'returns the offer in the result set' do
        expect(subject).to include(@offer)
      end
    end

    context 'when the ends_at field value of an offer is in the future' do
      before do
        @offer = create(:offer, ends_at: 2.days.from_now)
      end

      it 'returns the offer in the result set' do
        expect(subject).to include(@offer)
      end
    end

    context 'when the ends_at field value of an offer is in the past' do
      before do
        create(:offer, advertiser_name: 'expired today', ends_at: Date.today)
        create(:offer, advertiser_name: 'expired 2 days ago', ends_at: Date.today - 2.days)
      end

      it 'does not returns the offer in the result set' do
        expect(subject).to be_empty
      end
    end

    context 'when the starts_at field value of an offer is in the future' do
      before do
        create(:offer, advertiser_name: 'starts in 2 days', starts_at: 2.days.from_now)
      end

      it 'does not returns the offer in the result set' do
        expect(subject).to be_empty
      end
    end

    context 'when the starts_at field value of an offer is in the past' do
      before do
        @offer_started_today = create(:offer, advertiser_name: 'started today', starts_at: Date.today)
        @offer_started_yesterday = create(:offer, advertiser_name: 'started_yesterday', starts_at: Date.today - 1.day)
      end

      it 'returns the offer in the result set' do
        expect(subject).to include(@offer_started_today)
        expect(subject).to include(@offer_started_yesterday)
      end
    end

    context 'when the value of the available field of an offer is true' do
      context 'and the offer has not expired yet' do
        before do
          @offer = create(:offer, ends_at: 1.day.from_now)
        end

        it 'returns the offer in the result set' do
          expect(subject).to include(@offer)
        end
      end

      context 'but the offer has expired' do
        before do
          @offer = create(:offer, ends_at: Date.today - 1.day)
        end

        it 'does not returns the offer in the result set' do
          expect(subject).to be_empty
        end
      end
    end

    context 'when the value of the available field of an offer is false' do
      before do
        @offer = create(:offer, ends_at: 1.day.from_now, available: false)
      end

      it 'does not returns the offer in the result set even if the dates permits' do
        expect(subject).to be_empty
      end
    end
  end
end
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
        @offer = create(:offer, ends_at: Date.today + 2.days)
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
        create(:offer, advertiser_name: 'starts in 2 days', starts_at: Date.today + 2.days)
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
          @offer = create(:offer, ends_at: Date.today + 1.day)
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
        @offer = create(:offer, ends_at: Date.today + 1.day, available: false)
      end

      it 'does not returns the offer in the result set even if the dates permits' do
        expect(subject).to be_empty
      end
    end

    context 'when there are multiple offers created in different dates' do
      before do
        @offer_created_yesterday = create(:offer, advertiser_name: 'offer 1', created_at: Date.today - 1.day)
        @offer_created_today = create(:offer, advertiser_name: 'offer 2', created_at: Date.today)
        @offer_created_tomorrow = create(:offer, advertiser_name: 'offer 3', created_at: Date.today + 1.day)
      end

      it 'returns the records ordered from newest to oldest' do
        expect(subject[0]).to eq(@offer_created_tomorrow)
        expect(subject[1]).to eq(@offer_created_today)
        expect(subject[2]).to eq(@offer_created_yesterday)
      end
    end

    context 'when no search filters are applied' do
      let(:command) { ListOffersCommand.new(true) }

      subject { command.execute }

      before do
        @offer = create(:offer, created_at: Date.today - 3.day)
        @offer_expired = create(:offer, advertiser_name: 'offer expired', ends_at: Date.today - 2.days, created_at: Date.today - 2.day)
        @offer_unavailable = create(:offer, advertiser_name: 'offer unavailable', available: false, created_at: Date.today - 1.day)
      end

      it 'returns all the offers from the database' do
        expect(subject.size).to be(3)
      end

      it 'returns the records ordered from newest to oldest' do
        expect(subject[0]).to eq(@offer_unavailable)
        expect(subject[1]).to eq(@offer_expired)
        expect(subject[2]).to eq(@offer)
      end
    end
  end
end
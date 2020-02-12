# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateOfferCommand do
  describe '#execute' do
    let(:command) { UpdateOfferCommand.new(@old_offer.id, offer_attributes) }

    subject { command.execute }

    before do
      @old_offer = create(:offer)
    end

    context 'when all the given parameters are valid' do
      let(:offer_attributes) { attributes_for(:offer, fetch_new_attributes) }

      it 'updates the advertiser_name field' do
        expect { subject }.to(change { @old_offer.reload.advertiser_name })
      end

      it 'updates the description field' do
        expect { subject }.to(change { @old_offer.reload.description })
      end

      it 'updates the starts_at field' do
        expect { subject }.to(change { @old_offer.reload.starts_at })
      end

      it 'updates the ends_at field' do
        expect { subject }.to(change { @old_offer.reload.ends_at })
      end

      it 'updates the premium field' do
        expect { subject }.to(change { @old_offer.reload.premium })
      end

      it 'updates the available field' do
        expect { subject }.to(change { @old_offer.reload.available })
      end

      it 'returns a instance of the updated record' do
        expect(subject).to eq(@old_offer.reload)
      end
    end

    context 'when some invalid parameters are given' do
      let(:offer_attributes) { attributes_for(:offer, url: nil) }

      it 'raises a record invalid exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  private

  def fetch_new_attributes
    {
        advertiser_name: 'Amazon',
        url: 'https://www.amazon.com',
        description: '10% discount on games',
        starts_at: 2.days.ago.beginning_of_day,
        ends_at: 2.weeks.from_now.beginning_of_day,
        premium: true,
        available: false
    }
  end
end
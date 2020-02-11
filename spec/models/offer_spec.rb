require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:advertiser_name) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_presence_of(:starts_at) }
      it { is_expected.to validate_presence_of(:url) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:description).is_at_most(500) }
    end

    context 'uniqueness' do
      before { create(:offer) }
      it { is_expected.to validate_uniqueness_of(:advertiser_name).case_insensitive }
    end

    context 'uri' do
      it { is_expected.to allow_value('https://www.walmart.com').for('url') }
      it { is_expected.to_not allow_value('www.walmart.com').for('url').with_message('Must be a valid URI') }
    end
  end
end

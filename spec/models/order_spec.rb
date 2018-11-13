require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#shipped?' do
    it { is_expected.to respond_to(:shipped?) }

    context 'when a shipped date exists' do
      before { subject.update(shipped_at: Time.now) }
      it { is_expected.to be_shipped }
    end

    context 'when no shipped date is present' do
      it { is_expected.to_not be_shipped }
    end
  end

  describe '#settings' do
    it { is_expected.to respond_to(:settings) }

    context 'when expedite is present' do
      before { subject.update_settings!(:expedite, true) }
      it { is_expected.to be_expedited }
    end

    context 'when returns is present' do
      before { subject.update_settings!(:returns, true) }
      it { is_expected.to be_returnable }
    end

    context 'when warehouse is present' do
      before { subject.update_settings!(:warehouse, true) }
      it { is_expected.to be_warehoused }
    end

    Order::SETTING_ACCESSOR_WHITELIST.each do |valid_accessor|
      context "#{valid_accessor} toggling" do
        it 'should be able to go from true, back to false' do
          [true, false].each do |expectation|
            subject.update_settings!(valid_accessor, expectation)
            expect(subject.reload.send(valid_accessor)).to eq(expectation)
          end
        end
      end
    end
    
  end
end

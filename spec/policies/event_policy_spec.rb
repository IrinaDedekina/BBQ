require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:first_user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:event) { create(:event, user: first_user) }

  # объект тестирования (политика)
  subject { described_class }

  context 'when user in not an owner' do
    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(second_user, event) }
    end
  end

  context 'when user is the owner' do
    permissions :edit?, :destroy?, :update? do
      it { is_expected.to permit(first_user, event) }
    end
  end

  context 'registered user create event' do
    permissions :create? do
      it { is_expected.to permit(second_user, create(:event)) }
      it { is_expected.to permit(first_user, create(:event)) }
      it { is_expected.not_to permit(nil, Event) }
    end
  end
end

require 'rails_helper'

RSpec.describe Went, type: :model do
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe 'N:1の関係' do
      context 'user' do
        let(:target) { :user }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'User' }
      end
      context 'place' do
        let(:target) { :place }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'Place' }
      end
    end
  end
end

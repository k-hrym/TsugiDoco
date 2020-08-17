require 'rails_helper'

RSpec.describe PlaceImage, type: :model do
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe '1:Nの関係' do
      context 'tags' do
        let(:target) { :tags }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Tag' }
      end
    end

    describe 'N:1の関係' do
      context 'place' do
        let(:target) { :place }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'Place' }
      end
      context 'user' do
        let(:target) { :user }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'User' }
      end
    end
  end
end

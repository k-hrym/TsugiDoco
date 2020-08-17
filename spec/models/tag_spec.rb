require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe 'N:1の関係' do
      context 'place_image' do
        let(:target) { :place_image }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'PlaceImage' }
      end
    end
    describe '1:1の関係' do
      context 'place' do
        let(:target) { :place }
        it { expect(association.macro).to eq :has_one }
        it { expect(association.class_name).to eq 'Place' }
      end
    end
  end
end

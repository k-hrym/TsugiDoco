require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'バリデーションのテスト' do
    let(:spot) { create(:spot) }
    subject{ spot.valid? }

    context 'place_id' do
      it 'updateの時は空欄ではないこと' do
        spot.update(place_id: '')
        is_expected.to eq false
      end
      it 'updateの時は空欄の場合はエラーを表示' do
        spot.update(place_id: '')
        spot.valid?
        expect(spot.errors[:place_id]).to include('を入力してください')
      end
    end
    context 'route_id' do
      it '空欄ではないこと' do
        spot.route_id = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        spot.route_id = ''
        spot.valid?
        expect(spot.errors[:route_id]).to include('を入力してください')
      end
    end
    context 'order' do
      it '空欄ではないこと' do
        spot.order = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        spot.order = ''
        spot.valid?
        expect(spot.errors[:order]).to include('を入力してください')
      end
    end
    context 'memo' do
      it '200字以内であること' do
        spot.memo = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
      it '200字以内でない場合はエラーを表示' do
        spot.memo = Faker::Lorem.characters(number: 201)
        spot.valid?
        expect(spot.errors[:memo]).to include('は200文字以内で入力してください')
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe 'N:1の関係' do
      context 'route' do
        let(:target) { :route }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'Route' }
      end
      context 'place' do
        let(:target) { :place }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'Place' }
      end
    end
  end
end

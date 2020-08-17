require 'rails_helper'

RSpec.describe Route, type: :model do
  describe 'バリデーションのテスト' do
    let(:route) { create(:route) }
    subject { route.valid? }
    context 'titleカラム' do
      it '空欄ではないこと' do
        route.title = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        route.title = ''
        route.valid?
        expect(route.errors[:title]).to include('を入力してください')
      end
      it '50文字以内であること' do
        route.title = Faker::Lorem.characters(number: 51)
        route.valid?
        expect(route.errors[:title]).to include('は50文字以内で入力してください')
      end
    end

    context 'explanationカラム' do
      it '500文字以内であること' do
        route.explanation = Faker::Lorem.characters(number: 501)
        route.valid?
        expect(route.errors[:explanation]).to include('は500文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe '1:Nの関係' do
      context 'users' do
        let(:target) { :users }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'User' }
      end
      context 'spots' do
        let(:target) { :spots }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Spot' }
      end
      context 'places' do
        let(:target) { :places }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Place' }
      end
      context 'likes' do
        let(:target) { :likes }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Like' }
      end
    end

    describe 'N:1の関係' do
      context 'user' do
        let(:target) { :user }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'User' }
      end
    end
  end
end

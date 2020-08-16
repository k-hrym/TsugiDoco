require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'バリデーションのテスト' do
    let(:genre) { create(:genre) }
    subject{ genre.valid? }

    context 'nameカラム' do
      it '空欄ではないこと' do
        genre.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        genre.name = ''
        genre.valid?
        expect(genre.errors[:name]).to include('を入力してください')
      end
      it '10文字以内であること' do
        genre.name = Faker::Lorem.characters(number: 11)
        genre.valid?
        expect(genre.errors[:name]).to include('は10文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    describe '1:Nの関係' do
      context 'places' do
        let(:target) { :places }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Place' }
      end
    end
  end
end

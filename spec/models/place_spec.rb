require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:genre){ Genre.create(name: 'genre') }

  describe 'バリデーションのテスト' do
    let(:place) { Place.new(params) }
    let(:params) {{ name: 'test',genre_id: genre.id,address: '東京都新宿区' }}
    subject { place.valid? }
    context 'nameカラム' do
      it '空欄ではないこと' do
        place.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラー' do
        place.name = ''
        place.valid?
        expect(place.errors[:name]).to include("を入力してください")
      end
      it '50字以上はエラー' do
        place.name = Faker::Lorem.characters(number: 51)
        place.valid?
        expect(place.errors[:name]).to include("は50文字以内で入力してください")
      end
    end

    context 'addressカラム' do
      it '空欄ではないこと' do
        place.address = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラー' do
        place.address = ''
        place.valid?
        expect(place.errors[:address]).to include("を入力してください")
      end
      it '100字以上はエラー' do
        place.address = Faker::Lorem.characters(number: 101)
        place.valid?
        expect(place.errors[:address]).to include("は100文字以内で入力してください")
      end
    end

    context 'genre_idカラム' do
      it '空欄ではないこと' do
        place.genre_id = 'こんにちは'
        is_expected.to eq false
      end
      it '空欄の場合はエラー' do
        place.genre_id = ''
        place.valid?
        expect(place.errors[:genre_id]).to include("を入力してください")
      end
    end

    context 'explanationカラム' do
      it '300字以上はエラー' do
        place.explanation = Faker::Lorem.characters(number: 301)
        place.valid?
        expect(place.errors[:explanation]).to include("は300文字以内で入力してください")
      end
    end

    context 'postcodeカラム' do
      it '7文字以外はエラー' do
        place.postcode = Faker::Number.number(digits: 5)
        place.valid?
        expect(place.errors[:postcode]).to include("は7文字で入力してください")
      end
    end

    context 'accessカラム' do
      it '200字以上はエラー' do
        place.access = Faker::Lorem.characters(number: 201)
        place.valid?
        expect(place.errors[:access]).to include("は200文字以内で入力してください")
      end
    end

    context 'telカラム' do
      it '9以下はエラー' do
        place.tel = Faker::Number.number(digits: 9)
        place.valid?
        expect(place.errors[:tel]).to include("は10文字以上で入力してください")
      end
      it '12以上はエラー' do
        place.tel = Faker::Number.number(digits: 12)
        place.valid?
        expect(place.errors[:tel]).to include("は11文字以内で入力してください")
      end
    end

    context 'hoursカラム' do
      it '200字以上はエラー' do
        place.hours = Faker::Lorem.characters(number: 201)
        place.valid?
        expect(place.errors[:hours]).to include("は200文字以内で入力してください")
      end
    end

    context 'priceカラム' do
      it '200字以上はエラー' do
        place.price = Faker::Lorem.characters(number: 201)
        place.valid?
        expect(place.errors[:price]).to include("は200文字以内で入力してください")
      end
    end

    context 'holidayカラム' do
      it '200字以上はエラー' do
        place.holiday = Faker::Lorem.characters(number: 201)
        place.valid?
        expect(place.errors[:holiday]).to include("は200文字以内で入力してください")
      end
    end

  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      # reflect_on_associationで対象のクラスと引数で指定するクラスの
      # 関連を返します
      described_class.reflect_on_association(target)
    end

    describe '1:Nの関係' do
      context 'place_images' do
        let(:target) { :place_images }
        # macro メソッドで関連づけを返します
        it { expect(association.macro).to eq :has_many }
        # class_name で関連づいたクラス名
        it { expect(association.class_name).to eq 'PlaceImage' }
      end
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
      context 'routes' do
        let(:target) { :routes }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Route' }
      end
      context 'wents' do
        let(:target) { :wents }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Went' }
      end
      context 'wishes' do
        let(:target) { :wishes }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Wish' }
      end
      context 'tags' do
        let(:target) { :tags }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Tag' }
      end
    end

    describe 'N:1の関係' do
      context 'genre' do
        let(:target) { :genre }
        it { expect(association.macro).to eq :belongs_to }
        it { expect(association.class_name).to eq 'Genre' }
      end
    end
  end
end

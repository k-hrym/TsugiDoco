require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:user_2) { create(:user_2) }
    subject { user.valid? }
    context 'nameカラム' do
      it '空欄ではないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
      it '16字以上はエラーを表示' do
        user.name = Faker::Lorem.characters(number: 20)
        user.valid?
        expect(user.errors[:name]).to include("は15文字以内で入力してください")
      end
    end
    context 'emailカラム' do
      it '空欄ではないこと' do
        user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it 'ユニークであること' do
        user.email = 'dupli_test@test.com'
        user.save
        user_2.email = 'dupli_test@test.com'
        user_2.save
        expect(user_2).to be_invalid
      end
      it 'ユニークでない場合はエラーを表示' do
        user.email = 'dupli_test@test.com'
        user.save
        user_2.email = 'dupli_test@test.com'
        user_2.save
        expect(user_2.errors[:email]).to include("はすでに存在します")
      end
    end
    context 'passwordカラム' do
      it '空欄でないこと' do
        user.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        user.password = ''
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it '6文字以上であること' do
        user.password = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '６文字未満の場合はエラーを表示' do
        user.password = Faker::Lorem.characters(number: 1)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
      it 'パスワードが不一致' do
        user.password = "password1"
        user.password_confirmation = "password2"
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end

    context 'profileカラム' do
      it '400文字以内であること' do
        user.profile = Faker::Lorem.characters(number: 401)
        user.valid?
        expect(user.errors[:profile]).to include("は400文字以内で入力してください")
      end
    end
    context 'sexカラム' do
      it '[nil,0,1,2]のいずれかであること' do
        user.sex = 3
        user.valid?
        expect(user.errors[:sex]).to include("は一覧にありません")
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
      context 'places' do
        let(:target) { :places }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Place' }
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
      context 'relations' do
        let(:target) { :relations }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Relation' }
      end
      context 'followings' do
        let(:target) { :followings }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'User' }
      end
      context 'followers' do
        let(:target) { :followers }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'User' }
      end
      context 'likes' do
        let(:target) { :likes }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Like' }
      end
    end
  end
end

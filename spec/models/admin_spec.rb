require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'バリデーションのテスト' do
    let(:admin) { create(:admin) }
    subject { admin.valid? }

    context 'emailカラム' do
      it '空欄ではないこと' do
        admin.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        admin.email = ''
        admin.valid?
        expect(admin.errors[:email]).to include('を入力してください')
      end
    end

    context 'passwordカラム' do
      it '空欄でないこと' do
        admin.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーを表示' do
        admin.password = ''
        admin.valid?
        expect(admin.errors[:password]).to include("を入力してください")
      end
      it '6文字以上であること' do
        admin.password = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '６文字未満の場合はエラーを表示' do
        admin.password = Faker::Lorem.characters(number: 1)
        admin.valid?
        expect(admin.errors[:password]).to include("は6文字以上で入力してください")
      end
      it 'パスワードが不一致' do
        admin.password = "password1"
        admin.password_confirmation = "password2"
        admin.valid?
        expect(admin.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end

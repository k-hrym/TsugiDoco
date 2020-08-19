require 'rails_helper'

RSpec.describe "Admins::Users", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe 'ユーザーの一覧(index)ページのテスト' do
    context 'ユーザー一覧ページの表示' do
      it '成功する' do
        get admins_users_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ユーザーの編集(edit)ページのテスト' do
    context 'ユーザー編集ページの表示' do
      it '成功する' do
        get edit_admins_user_path user
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ユーザーの更新(update)機能のテスト' do
    context 'ユーザー更新' do
      it '成功する' do
        patch admins_user_path(user.id),params: { user: { is_valid: false }}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to admins_users_path
        expect(flash[:notice]).to include('保存しました')
      end
    end
  end

end

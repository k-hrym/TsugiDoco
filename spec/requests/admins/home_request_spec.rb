require 'rails_helper'

RSpec.describe "Admins::Homes", type: :request do
  let(:admin) { create(:admin) }

  describe 'ログインしていない場合' do
    context 'topページの表示' do
      it '失敗する' do
        get admins_top_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
  end

  describe 'ログインしている場合' do
    before { sign_in admin }
    context 'topページの表示' do
      it '成功する' do
        get admins_top_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end

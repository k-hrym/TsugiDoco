require 'rails_helper'

RSpec.describe "Publics::Relations", type: :request do
  let(:user) { create(:user) }
  let(:user_2) { create(:user_2) }
  before { sign_in user }
  describe 'フォロー機能テスト' do
    context 'user_2をフォローする' do
      it '成功する' do
        post relations_path, params: {id: user_2.id}, xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'アンフォロー機能テスト' do
    context 'user_2をアンフォローする' do
      before do
        # 事前にフォローしておく
        post relations_path, params: {id: user_2.id}, xhr: true
      end
      it '成功する' do
        delete relation_path(user_2.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end

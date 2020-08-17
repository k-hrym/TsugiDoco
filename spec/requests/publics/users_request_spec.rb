require 'rails_helper'

RSpec.describe "Publics::Users", type: :request do
  describe 'ログイン機能テスト' do
    # 存在するユーザー（DB登録ずみ）
    let(:existent_user) { create(:user) }
    # 存在しないユーザー(DB未登録)
    let(:non_existent_user) { build(:user) }
    let(:req_params) {{ user: { email: user.email, password: user.password } }}

    context 'GET /users/sign_in' do
      it 'ログイン画面の表示に成功すること' do
        get new_user_session_path
        expect(response).to have_http_status(200)
      end
    end
    context '存在するユーザーでログインすると' do
      let(:user) { existent_user }
      it '成功する' do
        post user_session_path, params: req_params
        expect(response).to redirect_to user
      end
    end
    context '存在しないユーザーでログインすると' do
      let(:user) { non_existent_user }
      it '失敗する' do
        post user_session_path, params: req_params
        expect(response.body).to include('メールアドレスまたはパスワードが違います')
      end
    end
  end
end

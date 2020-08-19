require 'rails_helper'

RSpec.describe "Admins", type: :request do

  describe 'ログイン機能テスト' do
    # 存在するユーザー（DB登録ずみ）
    let(:existent_admin) { create(:admin) }
    # 存在しないユーザー(DB未登録)
    let(:non_existent_admin) { build(:admin) }
    let(:req_params) {{ admin: { email: admin.email, password: admin.password } }}

    context 'GET /admins/sign_in' do
      it 'ログイン画面の表示に成功すること' do
        get new_admin_session_path
        expect(response).to have_http_status(200)
      end
    end
    context '存在するユーザーでログインすると' do
      let(:admin) { existent_admin }
      it '成功してマイページに移動する' do
        post admin_session_path, params: req_params
        expect(response).to redirect_to admins_top_path
      end
    end
    context '存在しないユーザーでログインすると' do
      let(:admin) { non_existent_admin }
      it '失敗してエラーメッセージが表示' do
        post admin_session_path, params: req_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('メールアドレスまたはパスワードが違います')
      end
    end
  end

  describe '未ログイン状態でのログイン画面以外へのアクセス制限テスト' do
    let(:place) { create(:place) }
    let(:genre) { create(:genre) }
    let(:route) { create(:route) }
    let(:user) { create(:user) }

    context 'topページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get admins_top_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'プレイス一括登録ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get new_admins_place_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'プレイス一覧ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get new_admins_place_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'プレイス編集ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get edit_admins_place_path place
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ジャンル一覧ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get admins_genres_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ジャンル登録ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get new_admins_genre_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ジャンル編集ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get edit_admins_genre_path genre
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ルート一覧ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get admins_routes_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ルート詳細ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get admins_route_path route
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ユーザー一覧ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get admins_users_path
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
    context 'ユーザー編集ページへアクセス' do
      it '失敗してログインページに飛ぶ' do
        get edit_admins_user_path user
        expect(response).to redirect_to new_admin_session_path
        expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
      end
    end
  end
end

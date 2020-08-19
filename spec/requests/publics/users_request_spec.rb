require 'rails_helper'

RSpec.describe "Publics::Users", type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user_2) }

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
      it '成功してマイページに移動する' do
        post user_session_path, params: req_params
        expect(response).to redirect_to user
      end
    end
    context '存在しないユーザーでログインすると' do
      let(:user) { non_existent_user }
      it '失敗してエラーメッセージが表示' do
        post user_session_path, params: req_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('メールアドレスまたはパスワードが違います')
      end
    end
  end

  describe '新規登録機能テスト' do
    # 必要情報が入っている
    let(:req_params) {{user: {name: 'test-user', email: 'test@test.com', password: 'password', password_confirmation: 'password'}}}
    # nameがブランクで必要情報が足りていない
    let(:name_blank_params) {{user: {name: '', email: 'test@test.com', password: 'password', password_confirmation: 'password'}}}

    context 'GET /users/sign_up' do
      it '新規登録画面の表示成功すること' do
        get new_user_registration_path
        expect(response).to have_http_status(200)
      end
    end
    context '必須情報が入力されている場合' do
      before { post user_registration_path, params: req_params }
      it '成功する' do
        expect(response).to have_http_status(302)
      end
      it '成功してマイページに移動する' do
        expect(response).to redirect_to User.last
      end
    end
    context 'nameが未入力' do
      it '失敗する' do
        post user_registration_path, params: name_blank_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('を入力してください')
      end
    end
  end

  describe 'ユーザー詳細(show)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }

      context 'マイページにアクセス' do
        before { get user_path user }
        it '成功する' do
          expect(response).to have_http_status(200)
        end
        it 'プロフィール編集リンクがある' do
          expect(response.body).to include('プロフィール編集')
        end
      end

      context '他のユーザーのページにログイン' do
        before { get user_path another_user }
        it '成功する' do
          expect(response).to have_http_status(200)
        end
        it 'プロフィール編集リンクがない' do
          expect(response.body).not_to include('プロフィール編集')
        end
      end
    end

    describe '未ログインの場合' do
      context 'ユーザーページにアクセス' do
        before { get user_path user }
        it '成功する' do
          expect(response).to have_http_status(200)
        end
        it 'プロフィール編集リンクがない' do
          expect(response.body).not_to include('プロフィール編集')
        end
      end
    end
  end

  describe 'ユーザー編集(edit)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }

      context '自分の編集ページにアクセス' do
        before { get edit_user_path  user }
        it '成功する' do
          expect(response).to have_http_status(200)
        end
      end

      context '他のユーザーのページにログイン' do
        before { get edit_user_path another_user }
        it '失敗してtopページに飛ぶ' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to include('アクセス権限がありません')
        end
      end
    end

    describe '未ログインの場合' do
      context 'ユーザーページにアクセス' do
        before { get edit_user_path user }
        it '失敗してログインページに飛ぶ' do
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

  describe 'ユーザー情報更新(update)テスト' do
    let(:user_params) {{name: '編集後',profile: '自己紹介文',birth: '1995/08/10'}}

    describe 'ログインしている時' do
      before do
        sign_in user
      end

      context '自分の情報を更新' do
        before { patch user_path  user, user: user_params }
        it 'リクエストが成功する' do
          expect(response).to have_http_status(302)
        end
        it '更新が成功する' do
          expect(user.reload.name).to eq '編集後'
          expect(user.reload.profile).to eq '自己紹介文'
          # expect(user.reload.birth).to eq Thu, 10 Aug 1995
        end
        it 'マイページにリダイレクト' do
          expect(response).to redirect_to user_path user
        end
      end

      context '他のユーザーの情報を更新' do
        before { patch user_path  another_user, user: user_params }
        it '失敗してtopページに飛ぶ' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to include('アクセス権限がありません')
        end
      end
    end

    describe '未ログインの場合' do
      context 'ユーザー情報を更新' do
        before { patch user_path  user, user: user_params }
        it '失敗してログインページに飛ぶ' do
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

  describe 'ユーザーのルート管理(route)ページテスト' do
    let(:user_params) {{name: '編集後',profile: '自己紹介文',birth: '1995/08/10'}}

    describe 'ログインしている時' do
      before do
        sign_in user
      end

      context '自分のルート管理ページにアクセス' do
        before { get user_routes_path }
        it '成功する' do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe '未ログインの場合' do
      context 'ルート管理ページにアクセス' do
        before { get user_routes_path }
        it '失敗してログインページに飛ぶ' do
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

  describe 'ユーザー退会アクション(hide)のテスト' do
    describe 'ログインしている時' do
      before do
        sign_in user
      end

      context 'ステータスを退会に更新' do
        it '成功する' do
          patch users_hide_path user
          expect(response).to have_http_status(302)
          expect(user.reload.is_valid).to eq false
          expect(flash[:notice]).to include('ご利用ありがとうございました。')
          expect(session[:name]).to eq nil
          expect(response).to redirect_to root_path
        end
      end
    end

    describe '未ログインの場合' do
      context 'ユーザー退会アクション' do
        before { patch users_hide_path user }
        it '失敗してログインページに飛ぶ' do
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
end

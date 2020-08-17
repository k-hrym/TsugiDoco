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
end

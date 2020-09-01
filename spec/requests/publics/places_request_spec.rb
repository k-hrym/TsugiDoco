require 'rails_helper'

RSpec.describe "Publics::Places", type: :request do
  let(:user) { create(:user) }
  let(:place) { create(:place) }
  let(:genre) { create(:genre) }
  let(:place_params) {{place:{
                        name: '編集後', #必須
                        genre_id: genre.id, #必須
                        explanation: '編集後の説明文',
                        postcode: '1112222',
                        address: '編集後の住所', #必須
                        access: 'アクセス',
                        tel: '12345678900',
                        url: 'https://tsugidoco.work',
                        hours: '営業時間',
                        price: '料金',
                        holiday: '定休日',
                        place_images_images: ['[]' ],
                        }}}
  let(:invalid_place_params) {{ place: {
                        name: '', #必須
                        genre_id: '',
                        explanation: '編集後の説明文',
                        postcode: '1112222',
                        address: '', #必須
                        access: 'アクセス',
                        tel: '12345678900',
                        url: 'https://tsugidoco.work',
                        hours: '営業時間',
                        price: '料金',
                        holiday: '定休日',
                        }}}

  describe 'プレイス一覧(index)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context 'プレイス一覧ページにアクセス' do
        it '成功する' do
          get places_path
          expect(response).to have_http_status(200)
        end
      end
    end
    describe '未ログインの時' do
      context 'プレイス一覧ページにアクセス' do
        it '成功する' do
          get places_path
          expect(response).to have_http_status(200)
        end
      end
    end
  end
  describe 'プレイス登録(new)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context 'プレイス登録ページにアクセス' do
        it '成功する' do
          get new_place_path
          expect(response).to have_http_status(200)
        end
      end
    end
    describe '未ログインの時' do
      context 'プレイス登録ページにアクセス' do
        it '失敗してログインページへリダイレクトする' do
          get new_place_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
  describe 'プレイス新規登録(create)のテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context '必須情報が入力されている時、プレイス新規登録リクエスト' do
        it '成功する' do
          post places_path,params: place_params
          expect(response).to have_http_status(302)
        end
      end
      context '必須情報が未入力の時、プレイス新規登録リクエスト' do
        it '失敗する' do
          post places_path,params: invalid_place_params
          expect(response).to have_http_status(200)
          expect(response.body).to include('を入力してください')
        end
      end
    end
    describe '未ログインの時' do
      context '必須情報が入力されていても、プレイス新規登録リクエスト' do
        it '失敗してログインページへリダイレクトする' do
          post places_path,params: place_params
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
  describe 'プレイス詳細(show)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context 'プレイス詳細ページにアクセス' do
        it '成功する' do
          get place_path place
          expect(response).to have_http_status(200)
        end
        it '行きたいボタンがある' do
          visit place_path place
          expect(page).to have_css '.fa-bookmark'
        end
      end
    end
    describe '未ログインの時' do
      context 'プレイス詳細ページにアクセス' do
        it '成功する' do
          get place_path place
          expect(response).to have_http_status(200)
        end
      end
    end
  end
  describe 'プレイス編集(edit)ページのテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context 'プレイス編集ページにアクセス' do
        it '成功する' do
          get edit_place_path place
          expect(response).to have_http_status(200)
        end
      end
    end
    describe '未ログインの時' do
      context 'プレイス編集ページにアクセス' do
        it '失敗してログインページへリダイレクトする' do
          get edit_place_path place
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
  describe 'プレイス情報更新(update)のテスト' do
    describe 'ログインしている時' do
      before { sign_in user }
      context '必須情報が入力されている時、プレイス情報更新リクエスト' do
        it '成功する' do
          patch place_path place, params: place_params
          expect(response).to have_http_status(302)
          expect(response).to redirect_to place
          expect(flash[:notice]).to include('保存しました')
        end
      end
      context '必須情報が未入力の時、プレイス情報更新リクエスト' do
        it '失敗する' do
          patch place_path place, params: invalid_place_params
          expect(response).to have_http_status(200)
          expect(response.body).to include('を入力してください')
        end
      end
    end
    describe '未ログインの時' do
      context 'プレイス情報更新リクエスト' do
        it '失敗してログインページへリダイレクトする' do
          patch place_path place, params: place_params
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Admins::Genres", type: :request do
  let(:admin) { create(:admin) }
  let(:genre) { create(:genre) }
  let(:genre_params) {{ genre: { name: 'テストジャンル' }}}
  let(:invalid_genre_params) {{ genre: { name: '' }}}
  before { sign_in admin }

  describe 'ジャンルの一覧(index)ページのテスト' do
    context 'ジャンル一覧ページの表示' do
      it '成功する' do
        get admins_genres_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ジャンルの新規登録(new)ページのテスト' do
    context 'ジャンル新規登録ページの表示' do
      it '成功する' do
        get new_admins_genre_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ジャンルの新規登録(create)機能のテスト' do
    context 'nameが入力されていれば、ジャンル新規登録' do
      it '成功する' do
        post admins_genres_path, params: genre_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to admins_genres_path
      end
    end
    context 'nameが未入力の場合、ジャンル新規登録' do
      it '失敗する' do
        post admins_genres_path, params: invalid_genre_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('を入力してください')
      end
    end
  end
  describe 'ジャンルの編集(edit)ページのテスト' do
    context 'ジャンル編集ページの表示' do
      it '成功する' do
        get edit_admins_genre_path genre
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ジャンルの更新(update)機能のテスト' do
    context 'ジャンルの更新' do
      it '成功する' do
        patch admins_genre_path genre, params: genre_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to admins_genres_path
      end
    end
    context 'nameが未入力の場合、ジャンル更新' do
      it '失敗する' do
        patch admins_genre_path genre, params: invalid_genre_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('を入力してください')
      end
    end
  end
end

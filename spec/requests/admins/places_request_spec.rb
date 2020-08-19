require 'rails_helper'

RSpec.describe "Admins::Places", type: :request do
  let(:admin) { create(:admin) }
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
                        place_images_images: ['[]'],
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
  before { sign_in admin }

  describe 'プレイスの一覧(index)ページのテスト' do
    context 'プレイス一覧ページの表示' do
      it '成功する' do
        get admins_places_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'プレイスの新規登録(new)ページのテスト' do
    context 'プレイス新規登録ページの表示' do
      it '成功する' do
        get new_admins_place_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'プレイスの編集(edit)ページのテスト' do
    context 'プレイス編集ページの表示' do
      it '成功する' do
        get edit_admins_place_path place
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'プレイスの更新(update)機能のテスト' do
    context '必須情報が入力されている状態でプレイスの更新' do
      it '成功する' do
        patch admins_place_path place, params: place_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to admins_places_path
      end
    end
    context '必須情報が未入力の場合のプレイス更新' do
      it '失敗する' do
        patch admins_place_path place, params: invalid_place_params
        expect(response).to have_http_status(200)
        expect(response.body).to include('を入力してください')
      end
    end
  end
end

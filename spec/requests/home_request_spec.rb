require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { create(:user) }

  describe 'ログインしている場合' do
    before { sign_in user }
    context 'topページの表示' do
      it '成功する' do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
    context 'aboutページの表示' do
      it '成功する' do
        get about_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'ログインしていない場合も' do
    context 'topページの表示' do
      it '成功する' do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
    context 'aboutページの表示' do
      it '成功する' do
        get about_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end

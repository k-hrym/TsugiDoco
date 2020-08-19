require 'rails_helper'

RSpec.describe "Admins::Routes", type: :request do
  let(:admin) { create(:admin) }
  let(:route) { create(:route) }
  before { sign_in admin }

  describe 'ルートの一覧(index)ページのテスト' do
    context 'ルート一覧ページの表示' do
      it '成功する' do
        get admins_routes_path
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'ルートの詳細(show)ページのテスト' do
    context 'ルート詳細ページの表示' do
      it '成功する' do
        get admins_route_path route
        expect(response).to have_http_status(:success)
      end
    end
  end
end

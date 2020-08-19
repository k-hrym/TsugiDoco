require 'rails_helper'

RSpec.describe "Publics::Spots", type: :request do
  let(:route) { create(:route) }

  context 'スポットの新規登録(create)機能のテスト' do
    it '成功する' do
      post spots_path(id: route.id),xhr: true
      expect(response).to have_http_status(200)
      # expect(page).to have_css(".spot__form-#{Spot.last.id}")
    end
  end
  context 'スポットの削除(destroy)機能のテスト' do
    before do
      # 事前にspotを作成
      post spots_path(id: route.id),xhr: true
    end
    it '成功する' do
      delete spot_path(Spot.last,route_id: route.id),xhr: true
      expect(response).to have_http_status(200)
    end
  end
end

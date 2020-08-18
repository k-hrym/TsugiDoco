require 'rails_helper'

RSpec.describe "Publics::Likes", type: :request do
  let(:route) { create(:route) }
  let(:user) { create(:user) }

  describe "ログイン済みの場合" do
    before { sign_in user }
    context 'いいねをする', js: true do
      it "成功する" do
        post route_likes_path(route.id), xhr: true
        expect(response).to have_http_status(:success)
      end
      # it 'いいねボタンの色が変わる', type: :feature do
      #   find('i','.heart__gray').click
      #   expect(page).to have_css('.heart__pink')
      # end
    end
    context "いいねを取り消す" do
      before do
        post route_likes_path(route.id), xhr: true
      end
      it "成功する" do
        delete route_likes_path(route.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end

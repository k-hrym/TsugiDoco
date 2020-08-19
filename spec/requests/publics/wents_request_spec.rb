require 'rails_helper'

RSpec.describe "Publics::Wents", type: :request do
  let(:place) { create(:place) }
  let(:user) { create(:user) }

  describe "ログイン済みの場合" do
    before { sign_in user }
    context 'いったをする', js: true do
      it "成功する" do
        post wents_path(id: place.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    context "いいねを取り消す" do
      before do
        post wents_path(id: place.id), xhr: true
      end
      it "成功する" do
        delete wents_path(id: place.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end

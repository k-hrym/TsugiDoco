require 'rails_helper'

RSpec.describe "Publics::Wishes", type: :request do
  let(:place) { create(:place) }
  let(:user) { create(:user) }

  describe "ログイン済みの場合" do
    before { sign_in user }
    context 'いきたいをする', js: true do
      it "成功する" do
        post wishes_path(id: place.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    context "いきたいを取り消す" do
      before do
        post wishes_path(id: place.id), xhr: true
      end
      it "成功する" do
        delete wishes_path(id: place.id), xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end

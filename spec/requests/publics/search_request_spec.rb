require 'rails_helper'

RSpec.describe "Publics::Searches", type: :request do

  describe "GET /search" do
    it "returns http success" do
      get search_path, params: { search: '検索' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('検索結果')
    end
  end

end

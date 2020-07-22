require 'rails_helper'

RSpec.describe "Publics::Searches", type: :request do

  describe "GET /search" do
    it "returns http success" do
      get "/publics/search/search"
      expect(response).to have_http_status(:success)
    end
  end

end

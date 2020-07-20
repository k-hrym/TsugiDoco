require 'rails_helper'

RSpec.describe "Publics::Likes", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/publics/likes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/publics/likes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

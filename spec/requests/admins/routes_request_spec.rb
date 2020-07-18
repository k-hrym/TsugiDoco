require 'rails_helper'

RSpec.describe "Admins::Routes", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admins/routes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admins/routes/show"
      expect(response).to have_http_status(:success)
    end
  end

end

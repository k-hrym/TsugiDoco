require 'rails_helper'

RSpec.describe "Admins::Users", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admins/users/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admins/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admins/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admins/users/update"
      expect(response).to have_http_status(:success)
    end
  end

end

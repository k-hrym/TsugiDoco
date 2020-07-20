require 'rails_helper'

RSpec.describe "Publics::Routes", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/publics/routes/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/publics/routes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/publics/routes/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/publics/routes/edit"
      expect(response).to have_http_status(:success)
    end
  end

end

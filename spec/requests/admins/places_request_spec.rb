require 'rails_helper'

RSpec.describe "Admins::Places", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admins/places/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admins/places/show"
      expect(response).to have_http_status(:success)
    end
  end

end

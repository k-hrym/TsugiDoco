require 'rails_helper'

RSpec.describe "Publics::Wishes", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/publics/wishes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/publics/wishes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "LandingPage", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/landing_page/"
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "LandingPage", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { login_as(user, scope: :user) }

  describe "GET /index" do
    it "returns http success" do
      get landing_page_index_path
      expect(response).to have_http_status(:success)
    end
  end
end

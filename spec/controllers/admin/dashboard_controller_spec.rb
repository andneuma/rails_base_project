require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      admin = create :user, :admin
      login_as admin

      get :index

      expect(response).to render_template :index
    end

    it 'returns 404 if not logged in as admin' do
      expect { get :index }.to raise_error(ActionController::RoutingError)
    end
  end
end

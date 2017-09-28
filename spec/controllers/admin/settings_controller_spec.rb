require 'rails_helper'

RSpec.describe Admin::SettingsController, type: :controller do
  before do
    login_as create(:user, :admin, email: 'batz@bar.org')
  end

  describe "GET #edit" do
    it 'populates settings' do
      settings = Admin::Setting.create!()
      get :edit

      expect(assigns(:settings)).to eq(settings)
      expect(assigns(:settings_hash)).to be_a(Hash)
    end

    it 'renders edit template' do
      get :edit

      expect(response).to render_template :edit
    end

    context 'rejects access' do
      it 'rejects access if not admin' do
        login_as create(:user)

        expect { get :edit }. to raise_error(ActionController::RoutingError)
      end

      it 'rejects access if not logged in' do
        session[:user_id] = nil

        expect { get :edit }. to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'GET #captcha-status' do
    context 'simple captcha' do
      it 'reports working for simple_captcha' do
        get :captcha_system_status, xhr: true, params: { captcha_system: 'simple_captcha' }

        expected_response = {status_code: 'working', status_message: 'Captcha system working'}.to_json
        expect(response.body).to eq expected_response
      end
    end
  end
end

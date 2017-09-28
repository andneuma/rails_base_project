require 'rails_helper'

describe SessionsController do
  context 'POST #create' do
    before do
      # Password == 'secret'
      @user = create :user, name: 'Norbert', email: 'foo@bar.org'
    end

    it 'Can login as activated users' do
      post :create, params: {
        session: { email: @user.email, password: 'secret' }
      }

      exp_response = { name: @user.name, email: @user.email }.to_json

      expect(session[:user_id]).to eq(@user.id)
      expect(response).to redirect_to root_path
    end

    it 'Returns 401 in case of wrong credentials' do
      post :create, params: {
        session: { email: @user.email, password: 'wrong_password' }
      }

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to login_path
    end

    it 'Returns 401 in case of non-activated users' do
      inactive_user = create :user, activated: false

      post :create, params: {
        session: { email: inactive_user.email, password: 'secret' }
      }

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to login_path
    end
  end

  context 'DESTROY #destroy' do
    it 'Can logout' do
      user = create :user, name: 'Norbert', email: 'foo@bar.org'
      login_as user
      get :destroy

      expect(session[:user_id]).to be_nil
    end
  end
end

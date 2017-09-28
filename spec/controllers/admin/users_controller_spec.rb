require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  context 'GET #index' do
    before do
      @admin = create :user, :admin
      login_as @admin
    end

    it 'renders proper template' do
      get :index

      expect(response).to render_template :index
      expect(assigns(:users).to_a).to eq [@admin]
    end
  end

  context 'POST #create' do
    it 'can add new user as admin' do
      login_as create :user, :admin

      expect {
        post :create, params: { user: {
          name: 'foo', email: 'foo@bar.org', password: 'secret', password_confirmation: 'secret', is_admin: false } }
      }.to change { User.count }.by(1)
    end

    it 'automatically activates new users if added as admin' do
      login_as create :user, :admin

      post :create, params: { user: {
        name: 'foo', email: 'foo@bar.org', password: 'secret', password_confirmation: 'secret', is_admin: false } }

      expect(User.find_by(name: 'foo').activated).to be true
    end
  end

  context 'PATCH #activate' do
    before do
      @user = create :user, activated: false
      login_as create :user, :admin
    end

    it 'can activate user' do
      patch :toggle_activation, params: { id: @user.id }

      expect(@user.reload.activated).to be true
    end
  end

  context 'DELETE #destroy' do
    before do
      @admins = create_list :user, 3, :admin
      login_as @admins.first
    end

    it 'deletes user' do
      expect {
        delete :destroy, params: { id: @admins.last.id }
      }.to change { User.count }.by(-1)
    end

    it 'does not delete own current user' do
      expect {
        delete :destroy, params: { id: @admins.first.id }
      }.to change { User.count }.by(0)
    end

    context 'rejects access' do
      it 'rejects access if not admin' do
        login_as create(:user)

        expect { delete :destroy, params: { id: @admins.first.id } }. to raise_error(ActionController::RoutingError)
      end

      it 'rejects access if not logged in' do
        session[:user_id] = nil

        expect { delete :destroy, params: { id: @admins.first.id } }. to raise_error(ActionController::RoutingError)
      end
    end
  end
end

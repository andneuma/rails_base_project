require 'rails_helper'

describe UsersController do
  context 'GET #edit' do
    let(:user) { create :user, name: 'Norbert' }

    it 'should populate users' do
      login_as user
      get :edit, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
    end

    it 'should render :edit template' do
      login_as user
      expect(

        get :edit, params: { id: user.id }
      ).to render_template :edit
    end

    context 'reject editing' do
      it 'if not logged in' do
        get :edit, params: { id: user.id }

        expect(response).not_to render_template :edit
      end

      it 'other groups users' do
        login_as user
        other_user = create :user, name: 'Susanne'
        get :edit, params: { id: other_user.id }

        expect(response).to redirect_to root_url
      end
    end
  end

  context 'GET #new' do
    let(:user) { create :user, name: 'Norbert' }

    before do
      get :new
    end

    it 'renders template :sign_up' do
      expect(response).to render_template :new
    end

    it 'populates new users in @users' do
      expect(assigns(:user)).to be_a(User)
    end
  end

  context 'POST #create' do
    context 'accept request' do
      before do
        @user = create :user, name: 'oneUser'
        @token = @user.activation_tokens.first.token

        post :create, params: {user: attributes_for(:user, name: 'AnotherUser', password: 'secret', password_confirmation: 'secret'), activation_token: @token }
        @user.reload
      end

      it 'creates new valid users if activation_token valid' do
        expect(User.count).to be 2
      end

      it 'invalidates a token on users create' do
        expect(@user.activation_tokens.first.redeemed).to be true
      end

      it 'redirects to map index after creating new users' do
        expect(response).to redirect_to root_url
      end
    end

    context 'reject request' do
      it 'if activation token not valid' do
        post :create, params: {user: attributes_for(:user, password: 'secret', password_confirmation: 'secret'), activation_token: 'SomeInvalidToken' }

        expect(response).to render_template :new
      end
    end
  end

  context 'PATCH #update' do
    let(:user) { create :user, name: 'Norbert' }

    it 'should update if attributes are valid' do
      login_as user
      patch :update, params: {id: user.id, user: { 
        name: 'SomeOtherName',
        email: 'foo@bar.batz',
        password: 'schnipp',
        password_confirmation: 'schnipp' } }

      user.reload do |user|
        expect(user.email).to eq('foo@bar.batz')
        expect(user.name).to eq('SomeOtherName')
      end
    end

    context 'reject updates' do
      it 'if not logged in' do
        patch :update, params: {id: user.id, user: {name: 'SomeOtherName' } }

        expect(user.reload.name).not_to eq('SomeOtherName')
      end

      it 'on other users' do
        login_as user
        other_user = create :user
        patch :update, params: {id: other_user.id, user: {name: 'SomeOtherName' } }

        expect(other_user.reload.name).not_to eq('SomeOtherName')
      end
    end
  end
end

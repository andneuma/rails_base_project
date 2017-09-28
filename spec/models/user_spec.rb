require 'rails_helper'

describe User do
  context 'Attributes' do
    it { is_expected.to respond_to :activated }
  end

  context 'Validations' do
    let(:user) { build :user, email: 'foo@bar.org' }

    it 'name cannot be blank' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it 'name cannot be longer than 50 chars' do
      user.name = 'c'*51
      expect(user).not_to be_valid
    end

    it 'password must be longer than 5 chars' do
      user.password = '123'
      user.password_confirmation = '123'
      expect(user).not_to be_valid
    end

    it 'cannot add users with invalid email' do
      user.email = 'foo@bar'
      expect(user).not_to be_valid
    end

    it 'cannot add users with duplicate email address' do
      create :user, email: 'foo@bar.org'
      another_user = build :user, email: 'foo@bar.org'

      expect(another_user).not_to be_valid
    end
  end

  context 'Regular users' do
    let(:user) { build :user }

    it 'users email is not blank' do
      expect(user.email.present?).to be true
    end

    it "users is not admin" do
      expect(user.admin?).not_to be true
    end

    it "users is signed in" do
      expect(user.signed_in?).to be true
    end
  end

  context 'Admin users' do
    let(:admin) { build :user, :admin}

    it 'admin users is admin' do
      expect(admin.admin?).to be true
    end
  end
end

require 'rails_helper'

RSpec.describe GuestUser do
  context 'Interface' do
    it { is_expected.to respond_to :id }
  end
end

require 'rails_helper'

describe Users::RegistrationsController, type: :controller do
  describe '#CREATE' do
    it 'assigns school_creator role' do # school_creator role after success registration
      params = { user: { email: 'user@example.com', password: 'password', password_confirmation: 'password' } }

      @request.env['devise.mapping'] = Devise.mappings[:user]
      post :create, params: params

      expect(User.last.has_role?(:school_creator)).to be(true)
    end
  end
end

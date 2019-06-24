require 'rails_helper'

describe Users::RegistrationsController, type: :controller do
  describe '#CREATE' do
    context 'when user is created' do
      it 'assigns school_admin role' do
        params = { email: 'user@example.com', password: 'password', password_confirmation: 'password' }

        @request.env['devise.mapping'] = Devise.mappings[:user]

        post :create, params: params

        expect(User.last.has_role?(:school_admin)).to be(true)
      end
    end
  end
end

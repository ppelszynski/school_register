require 'rails_helper'

describe SchoolsController, type: :controller do
  describe '#CREATE' do
    context 'when user is an admin' do
      let(:admin) { create(:user, :admin) }
      let(:params) { { school: { name: 'My new school', phone_number: '123456789', adress: 'City 1', status: 'public' } } }

      before do
        sign_in admin
      end

      it 'can create a new school' do
        expect { post :create, params: params }.to change { admin.schools.count }.by 1
      end
    end
    context 'when user is a school admin' do
      let(:user) { create(:user) }
      let(:neighbour) { create(:user) }
      let(:neighbour_school) { create(:school, admin_id: neighbour.id) }
      let(:params) { { school: { name: 'My new school', phone_number: '123456789', adress: 'City 1', status: 'public' } } }

      before do
        sign_in user
      end

      it 'cannot create a new school' do
        expect { post :create, params: params }.not_to change { School.count }
      end
      it 'cannot delete not own school' do
        expect { delete :destroy, params: { id: neighbour_school.id } }.not_to change { School.count }
      end
      it 'cannot edit not own school' do
        expect { patch(:update, params: { id: neighbour_school.id }.reverse_merge!(params)).not_to change { neighbour_school.name } }
      end
    end
  end
end

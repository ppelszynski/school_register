require 'rails_helper'

describe SchoolsController, type: :controller do
  describe '#CREATE' do
    context 'when user is an admin' do
      it 'can create a new school' do
        admin = create(:user, :admin)
        params = { school: { name: 'My new school', phone_number: '123456789', adress: 'City 1' } }

        sign_in admin

        expect { post :create, params: params }.to change { admin.schools.count }.by 1
        expect(admin.schools.last).to have_attributes(name: 'My new school', phone_number: '123456789', adress: 'City 1')
      end
    end
  end

  describe '#UPDATE' do
    context 'when user is a school admin' do
      it 'cannot edit not own school' do
        user = create(:user)
        neighbours_school = create(:school, admin_id: 0)
        params = { id: neighbours_school.id, school: { name: 'My new school', phone_number: '123456789', adress: 'City 1', status: 'public' } }

        sign_in user

        expect { patch(:update, params: params).not_to change { neighbours_school.name } }
      end
    end
  end

  describe '#DELETE' do
    context 'when user is a school admin' do
      it 'cannot delete not own school' do
        user = create(:user)
        neighbours_school = create(:school, admin_id: 0)

        sign_in user

        expect { delete :destroy, params: { id: neighbours_school.id } }.not_to change { School.count }
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it "validates the presence of the user's email and password" do
        post :create, params: { user: { email: '', password: '' } }
        expect(assigns(:user)).to be_a_new(User)
        expect(response).to render_template('new')
        #    expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 6 characters long' do
        post :create, params: { user: { email: 'zapala.grzegorz@gmai.com', password: '12345' } }
        expect(assigns(:user)).to be_a_new(User)
        expect(response).to render_template('new')
        #    expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'redirects user to new session on success' do
        post :create, params: { user: { email: 'zapala.grzegorz@gmai.com', password: '123456' } }
        # expect(assigns(:user)).to be_a_new(User)
        expect(response).to redirect_to new_session_path
      end
    end
  end
end

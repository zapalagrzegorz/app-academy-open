# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}
      expect(response).to be_success
      expect(response).to render_template('new')
    end
  end

  describe 'GET #show' do
    context 'with found user' do
      it 'show redirect to user page' do
        user = User.create(email: 'zapala.grzegorz@gmail.com', password: '123456')
        get :show, params: { id: user.id }

        expect(response).to be_successful
        expect(response).to render_template('show')
      end
    end
    context 'with no user' do
      it 'doesn\' show user' do
        begin
          get :show, params: { id: -1 }
        rescue StandardError
          # sens?
          # ActiveRecord::RecordNotFound
        end
        # expect(response).not_to be_successful
        # expect(response).to be_not_found
        # expect(response).to have_http_status(404)
        # debugger
        expect(response).not_to render_template(:show)
      end
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
        # user != nowy pusty user
        # expect(assigns(:user)).to be_a_new(User)
        expect(flash[:success]).to be_present
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'GET #activate' do
    before do
      @user = User.create(email: 'zapala.grzegorz@gmail.com', password: '123456')
    end
    context 'with invalid params' do
      it 'render text error message' do
        get :activate, params: { activation_token: 'abc' }
        expect(@user.activated).to eq false
        expect(response).not_to redirect_to root_url
        expect(response.body.downcase).to include 'invalid token'
      end
    end

    context 'with valid params' do
      it 'changes "activated" state to true' do
        get :activate, params: { activation_token: @user.activation_token }
        # debugger
        @user.reload
        # expect { ... }.to change { customer.reload.name }.from("Isaac").to("Newton")
        expect(@user.activated).to eq true
      end

      it 'redirect signed in user to root url' do
        get :activate, params: { activation_token: @user.activation_token }
        expect(flash[:success]).to be_present
        expect(response).to redirect_to root_url
      end
    end
  end
end

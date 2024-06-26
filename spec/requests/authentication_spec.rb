require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /sign_up' do
    let(:valid_attributes) { { name: 'John Doe', email: 'john@example.com', password: 'password' } }

    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post '/sign_up', params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns a token' do
        post '/sign_up', params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['token']).to be_present
      end
    end
  end

  describe 'POST /sign_in' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns a token' do
        post '/sign_in', params: { email: user.email, password: user.password }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['token']).to be_present
      end
    end
  end
end

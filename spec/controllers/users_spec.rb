require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    let!(:user) { create(:user, email:'miotyan@example.com') }
    let!(:another_user) { create(:user, email:'yukko@example.com') }

    it 'リクエストが成功し、ユーザー名が表示されること' do
      aggregate_failures do
        get users_path
        expect(response.status).to eq 200
        expect(response.body).to include user.email
        expect(response.body).to include another_user.email
      end
    end
  end

  describe 'GET /users/:id' do
    context 'ユーザーが存在する場合' do
      let(:user) { create(:user) }

      it 'リクエストが成功し、ユーザー名が表示されること' do
        aggregate_failures do
          get user_path(user)
          expect(response.status).to eq 200
          expect(response.body).to include 'sample@example.com'
        end
      end
    end

    context 'ユーザーが存在しない場合' do
      it 'リクエストに失敗すること' do
        expect { get user_path(0) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

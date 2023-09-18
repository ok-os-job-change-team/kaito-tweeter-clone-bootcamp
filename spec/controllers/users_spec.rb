require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    before do
      FactoryBot.create :takashi
      FactoryBot.create :satoshi
    end

    it 'リクエストが成功し、ユーザー名が表示されること' do
      aggregate_failures do
        get users_path
        expect(response.status).to eq 200
        expect(response.body).to include 'takashi@example.com'
        expect(response.body).to include 'satoshi@example.com'
      end
    end
  end

  describe 'GET /users/:id' do
    context 'ユーザーが存在する場合' do
      let(:takashi) { FactoryBot.create :takashi }

      it 'リクエストが成功し、ユーザー名とパスワードが表示されること' do
        aggregate_failures do
          get user_path(takashi)
          expect(response.status).to eq 200
          expect(response.body).to include 'takashi@example.com'
          expect(response.body).to include 'hoge_takashi'
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

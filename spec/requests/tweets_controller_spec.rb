RSpec.describe TweetsController, type: :request do
  describe 'GET /tweets' do
    context 'ツイート一覧にアクセスした場合' do
      let!(:user) { create(:user) }
      let!(:tweet) { create(:tweet, user_id: user.id) }

      it 'リクエストが成功し、ツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweets_path
          expect(response.status).to eq 200
          expect(response.body).to include tweet.tweet_content
          expect(response.body).to include user.email
        end
      end
    end
  end

  describe 'GET /tweets/:id' do
    context 'ツイートが存在する場合' do
      let!(:user) { create(:user) }
      let!(:tweet) { create(:tweet, user_id: user.id) }

      it 'リクエストが成功し、ツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweet_path(tweet.id)
          expect(response.status).to eq 200
          expect(response.body).to include tweet.tweet_content
          expect(response.body).to include user.email
        end
      end
    end

    context 'ツイートが存在しない場合' do
      it 'リクエストに失敗すること' do
        expect { get tweet_path(0) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

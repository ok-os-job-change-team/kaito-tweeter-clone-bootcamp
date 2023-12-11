RSpec.describe TweetsController, type: :request do
  describe 'GET /tweets' do
    let!(:user) { create(:user) }
    let!(:tweet) { create(:tweet, user_id: user.id) }

    context 'ログインしているとき、ツイート一覧にアクセスした場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'リクエストが成功し、ツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweets_path
          expect(response.status).to eq 200
          expect(response.body).to include tweet.tweet_content
          expect(response.body).to include user.email
        end
      end
    end

    context 'ログインしていないとき、ツイート一覧にアクセスした場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          get tweets_path
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'GET /tweets/:id' do
    let!(:user) { create(:user) }
    let!(:tweet) { create(:tweet, user_id: user.id) }

    context 'ログインしているとき、ツイート詳細にアクセスした場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'リクエストが成功し、ツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweet_path(tweet.id)
          expect(response.status).to eq 200
          expect(response.body).to include tweet.tweet_content
          expect(response.body).to include user.email
        end
      end
    end

    context 'ログインしていないとき、ツイート詳細にアクセスした場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          get tweet_path(tweet.id)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end

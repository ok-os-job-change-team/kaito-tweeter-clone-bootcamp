RSpec.describe TweetsController, type: :request do
  describe 'GET /tweets' do
    let!(:user) { create(:user) }
    let!(:tweet) { create(:tweet, user_id: user.id) }

    context 'ログインしているとき、ツイート一覧ページにアクセスした場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'リクエストが成功し、タイトルとツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweets_path
          expect(response.status).to eq 200
          expect(response.body).to include tweet.title
          expect(response.body).to include tweet.text_area
          expect(response.body).to include user.email
        end
      end
    end

    context 'ログインしていないとき、ツイート一覧ページにアクセスした場合' do
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

    context 'ログインしているとき、ツイート詳細ページにアクセスした場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'リクエストが成功し、タイトルとツイートとメールアドレスが表示されること' do
        aggregate_failures do
          get tweet_path(tweet.id)
          expect(response.status).to eq 200
          expect(response.body).to include tweet.title
          expect(response.body).to include tweet.text_area
          expect(response.body).to include user.email
        end
      end
    end

    context 'ログインしていないとき、ツイート詳細ページにアクセスした場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          get tweet_path(tweet.id)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'GET /tweets/new' do
    let!(:user) { create(:user) }

    context 'ログインしているとき、ツイート投稿ページにアクセスした場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'リクエストが成功し、ツイート投稿ページが表示されること' do
        aggregate_failures do
          get new_tweet_path
          expect(response.status).to eq 200
          expect(response.body).to include 'ツイート投稿'
        end
      end
    end

    context 'ログインしていないとき、ツイート投稿ページにアクセスした場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          get new_tweet_path
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'POST /tweets' do
    let!(:user) { create(:user) }

    context 'ログインしているとき、ツイートを投稿した場合' do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'ツイートの投稿に成功し、ツイート一覧ページにリダイレクトすること' do
        aggregate_failures do
          expect{
          post tweets_path params: { tweet: { title: 'sample_title', text_area: 'sample_text', user_id: user.id } }
          } .to change(Tweet, :count).by(1)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to tweets_path
        end
      end
    end

    context 'ログインしていないとき、ツイートを投稿した場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          expect{
          post tweets_path params: { tweet: { title: 'sample_title', text_area: 'sample_text', user_id: user.id } }
          } .to change(Tweet, :count).by(0)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end

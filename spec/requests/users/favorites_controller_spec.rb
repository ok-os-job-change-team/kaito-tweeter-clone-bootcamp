RSpec.describe Users::FavoritesController, type: :request do
  describe 'GET /tweets/favorite' do
    let!(:user) { create(:user) }
    let!(:another_user) { create(:user, email: 'hoge@example.com') }
    let!(:tweet) { create(:tweet, user: user) }
    let!(:another_tweet) { create(:tweet, user: another_user, title: 'another_title', content: 'another_content') }

    context 'ログインしているとき、いいね一覧ページにアクセスした場合' do
      before do
        # userとしてログイン
        post login_path, params: { email: user.email, password: user.password }
        # another_userが投稿主のanother_tweetをいいね登録
        post tweet_favorites_path(another_tweet), params: { tweet_id: another_tweet.id }
      end

      it 'リクエストが成功し、いいねしたひとりごとのタイトルと本文が表示されること' do
        aggregate_failures do
          get user_favorites_path(user)
          expect(response.status).to eq 200
          expect(response.body).to include another_tweet.title
          expect(response.body).to include another_tweet.content
        end
      end
    end

    context 'ログインしていないとき、いいね一覧ページにアクセスした場合' do
      it 'ログインページにリダイレクトすること' do
        aggregate_failures do
          get user_favorites_path(user)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end

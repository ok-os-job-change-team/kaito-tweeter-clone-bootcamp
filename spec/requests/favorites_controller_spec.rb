RSpec.describe FavoritesController, type: :request do
  describe 'POST /tweets/:tweet_id' do
    context 'ログインしているとき、ツイートに対していいね登録した場合' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user_id: user.id) }

      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it 'いいねの数が1増えること' do
        aggregate_failures do
          expect do
            post tweet_favorites_path(tweet), params: { tweet_id: tweet.id }
          end.to change(Favorite, :count).by(1)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(tweets_path)
        end
      end
    end

    context 'ログインしていないとき、ツイートに対していいね登録した場合' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user_id: user.id) }

      it 'いいねの数が変化せず、ログインページにリダイレクトすること' do
        aggregate_failures do
          expect do
            post tweet_favorites_path(tweet), params: { tweet_id: tweet.id }
          end.to change(Favorite, :count).by(0)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'DELETE /tweets/:tweet_id' do
    context 'ログインしているとき、ツイートに対していいね削除した場合' do
      let!(:favorite) { create(:favorite) }

      before do
        post login_path, params: { email: favorite.user.email, password: favorite.user.password }
      end

      it 'いいねの数が1減ること' do
        aggregate_failures do
          expect do
            delete tweet_favorites_path(favorite.tweet), params: { tweet_id: favorite.tweet.id }
          end.to change(Favorite, :count).by(-1)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(tweets_path)
        end
      end
    end

    context 'ログインしていないとき、ツイートに対していいね削除した場合' do
      let!(:favorite) { create(:favorite) }

      it 'いいねの数が変化せず、ログインページにリダイレクトすること' do
        aggregate_failures do
          expect do
            delete tweet_favorites_path(favorite.tweet), params: { tweet_id: favorite.tweet.id }
          end.to change(Favorite, :count).by(0)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end

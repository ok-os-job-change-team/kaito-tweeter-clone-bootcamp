RSpec.describe FavoritesController, type: :request do
    describe 'POST /users/:user_id/relationships' do
      context 'ログインしているとき、ユーザーをフォローした場合' do
        let!(:user) { create(:user) }
        let!(:another_user) { create(:user, email: 'another_user@example.com') }
  
        before do
          post login_path, params: { email: user.email, password: user.password }
        end
  
        it 'フォローの数が1増えること' do
          aggregate_failures do
            expect do
              post user_relationships_path(user), params: { user_id: another_user.id }
            end.to change(Relationship, :count).by(1)

            # binding.pry

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(users_path)
          end
        end
      end
  
      context 'ログインしていないとき、ユーザーをフォローした場合' do
        let!(:user) { create(:user) }
        let!(:another_user) { create(:user, email: 'another_user@example.com') }
  
        it 'フォローの数が変化せず、ログインページにリダイレクトすること' do
          aggregate_failures do
            # expect do
            #   post tweet_favorites_path(tweet), params: { tweet_id: tweet.id }
            # end.to change(Favorite, :count).by(0)
            # expect(response).to have_http_status(:found)
            # expect(response).to redirect_to login_path
          end
        end
      end
    end
  
    describe 'DELETE /users/:user_id/relationships' do
      context 'ログインしているとき、ユーザーのフォローを解除した場合' do
        let!(:user) { create(:user) }
        let!(:another_user) { create(:user, email: 'another_user@example.com') }
  
        before do
          post login_path, params: { email: favorite.user.email, password: favorite.user.password }
        end
  
        it 'フォローの数が1減ること' do
          aggregate_failures do
            # expect do
            #   delete tweet_favorites_path(favorite.tweet), params: { tweet_id: favorite.tweet.id }
            # end.to change(Favorite, :count).by(-1)
            # expect(response).to have_http_status(:found)
            # expect(response).to redirect_to(tweets_path)
          end
        end
      end
  
      context 'ログインしていないとき、ユーザーのフォローを解除した場合' do
        let!(:user) { create(:user) }
        let!(:another_user) { create(:user, email: 'another_user@example.com') }
  
        it 'フォローの数が変化せず、ログインページにリダイレクトすること' do
          aggregate_failures do
            # expect do
            #   delete tweet_favorites_path(favorite.tweet), params: { tweet_id: favorite.tweet.id }
            # end.to change(Favorite, :count).by(0)
            # expect(response).to have_http_status(:found)
            # expect(response).to redirect_to login_path
          end
        end
      end
    end
  end
  
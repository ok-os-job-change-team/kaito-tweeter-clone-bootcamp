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
          expect(response.body).to include tweet.tweet_title
          expect(response.body).to include tweet.tweet_content
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
          expect(response.body).to include tweet.tweet_title
          expect(response.body).to include tweet.tweet_content
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
          post tweets_path params: { tweet: { tweet_title: 'sample_title', tweet_content: 'sample_content', user_id: user.id } }
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
          post tweets_path params: { tweet: { tweet_title: 'sample_title', tweet_content: 'sample_content', user_id: user.id } }
          } .to change(Tweet, :count).by(0)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'GET tweets/:id/edit' do
    let!(:tweet) { create(:tweet, user_id: user.id) }

    context 'ログインユーザーと同じユーザーのツイート修正ページへアクセスする場合' do
      let!(:user) { create(:user) }

      before do
        post login_path, params: { email: user.email, password: 'sample_password' }
      end

      it 'ツイート修正ページに遷移すること' do
        aggregate_failures do
          get edit_tweet_path(tweet.id)
          expect(response.status).to eq 200
          expect(response.body).to include 'ツイート修正'
        end
      end
    end

    context 'ログインユーザーと異なるユーザーのツイート変更ページへアクセスする場合' do
      let!(:user) { create(:user) }
      let!(:another_user) { create(:user, email:'yukko@example.com') }

      before do
        post login_path, params: { email: another_user.email, password: 'sample_password' }
      end

      it 'ユーザーリストページにリダイレクトすること' do
        aggregate_failures do
          get edit_tweet_path(tweet.id)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to users_path
        end
      end
    end
  end

  describe 'PUT /tweets/:id' do
    let!(:tweet) { create(:tweet, user_id: user.id) }

    context 'ログインユーザーと同じユーザーのツイートを修正し、なおかつタイトルとツイートが正常な場合' do
      let!(:user) { create(:user) }

      before do
        post login_path, params: { email: user.email, password: 'sample_password' }
      end

      it 'ツイートの修正に成功すること' do
        aggregate_failures do
          put tweet_path(tweet.id), params: { tweet: { tweet_title: 'new_title', tweet_content: 'new_content', user_id: user.id } }
          expect(tweet.reload.tweet_title).to eq 'new_title'
          expect(tweet.reload.tweet_content).to eq 'new_content'
        end
      end
    end

    context 'ログインユーザーと同じユーザーのツイートを修正し、なおかつタイトルとツイートが異常で、バリデーションエラーとなる場合' do
      let!(:user) { create(:user) }

      before do
        post login_path, params: { email: user.email, password: 'sample_password' }
      end

      it 'ツイートの修正に失敗すること' do
        aggregate_failures do
          put tweet_path(tweet.id), params: { tweet: { tweet_title: '', tweet_content: '', user_id: user.id } }
          expect(tweet.reload.tweet_title).to eq tweet.tweet_title
          expect(tweet.reload.tweet_content).to eq tweet.tweet_content
          expect(response.body).to include '修正に失敗しました'
        end
      end
    end

    context 'ログインユーザーと異なるユーザーのツイートを修正する場合' do
      let!(:user) { create(:user) }
      let!(:another_user) { create(:user, email:'yukko@example.com') }

      before do
        post login_path, params: { email: another_user.email, password: 'sample_password' }
      end

      it 'ユーザーリストページにリダイレクトすること' do
        aggregate_failures do
          put tweet_path(tweet.id), params: { tweet: { tweet_title: 'new_title', tweet_content: 'new_content', user_id: user.id } }
          expect(response).to have_http_status(302)
          expect(response).to redirect_to users_path
        end
      end
    end
  end
end

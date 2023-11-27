RSpec.describe SessionsController, type: :request do
  describe 'GET /login' do
    it 'ログイン画面の表示に成功すること' do
      aggregate_failures do
        get login_path
        expect(response).to have_http_status(200)
      end
    end
  end
end

describe 'POST /login' do
  context '有効なemailとpasswordの場合' do
    let!(:user) { create(:user) }

    it 'ログインに成功すること' do
      aggregate_failures do
        post login_path, params: { email: user.email, password: 'sample_password' }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_path(user.id))
      end
    end
  end

  context '無効なemailとpasswordの場合' do
    let!(:user) { create(:user) }

    it 'ログインに失敗すること' do
      aggregate_failures do
        post login_path, params: { email: '', password: '' }
        expect(response).to have_http_status(200)
        expect(response.body).to include 'メールアドレスかパスワードが間違っています'
      end
    end
  end

  describe 'DELETE /logout' do
    context 'ログインしている場合' do
      let!(:user) { create(:user) }
  
      it 'ログアウトに成功すること' do
        aggregate_failures do
          post login_path, params: { email: user.email, password: 'sample_password' }
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(user_path(user.id))
          delete logout_path
          expect(response).to have_http_status(302)
          expect(response).to redirect_to login_path
          expect(session[:user_id]).to eq nil
          delete logout_path
        end
      end
    end
  end

  context 'ログインしていない場合' do
    let!(:user) { create(:user) }

    it 'ログアウトに失敗すること' do
      aggregate_failures do
      end
    end
  end
end

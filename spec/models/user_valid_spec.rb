RSpec.describe User do
  describe '#presenseメソッド' do
    context 'emailが存在する場合' do
      it 'valid?がtrueになる' do
        user = User.new(email: 'hoge@example.com', password: 'password')
        expect(user.valid?).to eq true
      end
    end

    context 'emailが空文字の場合' do
      it 'errorsに「メールアドレスを入力してください」と格納される' do
        user = User.new(email: '', password: 'password')
        user.valid?
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end
    end

    context 'emailがnilの場合' do
      it 'errorsに「メールアドレスを入力してください」と格納される' do
        user = User.new(email: nil, password: 'password')
        user.valid?
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end
    end

    context 'passwordが存在する場合' do
      it 'valid?がtrueになる' do
        user = User.new(email: 'hoge@example.com', password: 'password')
        expect(user.valid?).to eq true
      end
    end

    context 'passwordが空文字の場合' do
      it 'errorsに「パスワードを入力してください」と格納される' do
        user = User.new(email: 'hoge@example.com', password: '')
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end
    end

    context 'passwordがnilの場合' do
      it 'errorsに「パスワードを入力してください」と格納される' do
        user = User.new(email: 'hoge@example.com', password: nil)
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end
    end
  end
end

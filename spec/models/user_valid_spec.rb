RSpec.describe User do
  describe '#presenseメソッド' do
    context 'emailが存在する場合' do
      let(:user) { build(:user, email: 'hoge@example.com') }

      it 'valid?がtrueになる' do
        expect(user.valid?).to eq true
      end
    end

    context 'emailが空文字の場合' do
      let(:user) { build(:user, email: '') }

      it 'valid?がfalseになる' do
        expect(user.valid?).to eq false
      end

      it 'errorsに「メールアドレスを入力してください」と格納される' do
        user.valid?
        expect(user.errors.full_messages).to include('メールアドレスを入力してください')
      end
    end

    context 'emailがnilの場合' do
      let(:user) { build(:user, email: nil) }

      it 'valid?がfalseになる' do
        expect(user.valid?).to eq false
      end

      it 'errorsに「メールアドレスを入力してください」と格納される' do
        user.valid?
        expect(user.errors.full_messages).to include('メールアドレスを入力してください')
      end
    end

    context 'passwordが存在する場合' do
      let(:user) { build(:user, password: 'hogehoge') }

      it 'valid?がtrueになる' do
        expect(user.valid?).to eq true
      end
    end

    context 'passwordが空文字の場合' do
      let(:user) { build(:user, password: '') }

      it 'valid?がfalseになる' do
        expect(user.valid?).to eq false
      end

      it 'errorsに「パスワードを入力してください」と格納される' do
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end
    end

    context 'passwordがnilの場合' do
      let(:user) { build(:user, password: nil) }

      it 'valid?がfalseになる' do
        expect(user.valid?).to eq false
      end

      it 'errorsに「パスワードを入力してください」と格納される' do
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end
    end
  end
end

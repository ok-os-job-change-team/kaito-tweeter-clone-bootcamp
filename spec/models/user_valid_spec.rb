RSpec.describe User do
  describe '#presenseメソッド' do
    context 'emailが存在する場合' do
      it 'trueになる' do
        user = User.new(email: 'hoge@example.com', password: 'password')
        expect(user.valid?).to eq true
      end
    end

    context 'emailが存在しない場合' do
      it 'falseになる' do
        user = User.new(email: '', password: 'password')
        expect(user.valid?).to eq false
      end
    end

    context 'emailがnilの場合' do
      it 'falseになる' do
        user = User.new(email: nil, password: 'password')
        expect(user.valid?).to eq false
      end
    end

    context 'passwordが存在する場合' do
      it 'trueになる' do
        user = User.new(email: 'hoge@example.com', password: 'password')
        expect(user.valid?).to eq true
      end
    end

    context 'passwordが存在しない場合' do
      it 'falseになる' do
        user = User.new(email: 'hoge@example.com', password: '')
        expect(user.valid?).to eq false
      end
    end

    context 'passwordがnilの場合' do
      it 'falseになる' do
        user = User.new(email: 'hoge@example.com', password: nil)
        expect(user.valid?).to eq false
      end
    end
  end
end

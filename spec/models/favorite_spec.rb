RSpec.describe Favorite do
  describe 'バリデーションのテスト' do
    context 'user_idとtweet_idが存在する場合' do
      let(:favorite) { create(:favorite) }

      it 'valid?がtrueになる' do
        expect(favorite.valid?).to eq true
      end
    end

    context 'user_idがnilの場合' do
      let(:favorite) { create(:favorite) }

      it 'valid?がfalseになり、errorsに「ユーザidを入力してください」と格納される' do
        aggregate_failures do
          favorite.user_id = nil
          expect(favorite.valid?).to eq false
          expect(favorite.errors.full_messages).to include('ユーザーidを入力してください')
        end
      end
    end

    context 'tweet_idがnilの場合' do
      let(:favorite) { create(:favorite) }

      it 'valid?がfalseになり、errorsに「ツイートidを入力してください」と格納される' do
        aggregate_failures do
          favorite.tweet_id = nil
          expect(favorite.valid?).to eq false
          expect(favorite.errors.full_messages).to include('ツイートidを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nの関係になっていること' do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context 'Tweetモデルとの関係' do
      it '1:Nの関係になっていること' do
        association = described_class.reflect_on_association(:tweet)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end

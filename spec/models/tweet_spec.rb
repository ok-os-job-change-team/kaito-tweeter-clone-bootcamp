RSpec.describe Tweet do
  describe 'バリデーションのテスト' do
    context 'contetとtitleが正常な場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, user_id: user.id) }

      it 'valid?がtrueになり、errorsに何も格納されないこと' do
        aggregate_failures do
          expect(tweet.valid?).to eq true
          expect(user.errors.full_messages).to eq []
        end
      end
    end

    context 'contentが140字より長い場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, content: Faker::Lorem.characters(number: 141), user_id: user.id) }

      it 'valid?がfalseになり、errorsに「本文は140字以内で入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['本文は140字以内で入力してください']
        end
      end
    end

    context 'contentが空文字の場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, content: '', user_id: user.id) }

      it 'valid?がfalseになり、errorsに「本文を入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['本文を入力してください']
        end
      end
    end

    context 'contentがnilの場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, content: nil, user_id: user.id) }

      it 'valid?がfalseになり、errorsに「本文を入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['本文を入力してください']
        end
      end
    end

    context 'titleが20字より長い場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, title: Faker::Lorem.characters(number: 21), user_id: user.id) }

      it 'valid?がfalseになり、errorsに「タイトルは20字以内で入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['タイトルは20字以内で入力してください']
        end
      end
    end

    context 'titleが空文字の場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, title: '', user_id: user.id) }

      it 'valid?がfalseになり、errorsに「タイトルを入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['タイトルを入力してください']
        end
      end
    end

    context 'titleがnilの場合' do
      let(:user) { create(:user) }
      let(:tweet) { build(:tweet, title: nil, user_id: user.id) }

      it 'valid?がfalseになり、errorsに「タイトルを入力してください」と格納される' do
        aggregate_failures do
          result = tweet.valid?
          expect(result).to eq false
          expect(tweet.errors.full_messages).to eq ['タイトルを入力してください']
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
  end
end

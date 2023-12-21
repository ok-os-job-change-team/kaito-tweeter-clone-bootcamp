RSpec.describe FavoritesController, type: :request do
  describe 'POST /tweets/:tweet_id' do
    context 'ツイートに対していいね登録したとき' do
      let!(:user) { create(:user) }

      it 'いいねの数が1増えること' do
        aggregate_failures do
        end
      end
    end
  end
end

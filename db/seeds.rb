User.create(email: 'kaito@example.com', password: 'hogehoge')
User.create(email: 'shoichi@example.com', password: 'hohogege')

Tweet.create(user_id: 1, title: 'あいさつ', content: 'こんにちは')
Tweet.create(user_id: 2, title: '天気', content: '今日は晴れです')

Favorite.create(user_id: 1, tweet_id: 2)
Favorite.create(user_id: 2, tweet_id: 1)

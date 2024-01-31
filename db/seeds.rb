User.create(name: 'かいと', email: 'kaito@example.com', password: 'hogehoge')
User.create(name: 'しょーいち',email: 'shoichi@example.com', password: 'hohogege')

# Tweetsテーブル初期値
Tweet.create(user_id: 1, title: 'あいさつ', content: 'こんにちは')
Tweet.create(user_id: 2, title: '天気', content: '今日は晴れです')

# Favoriesテーブル初期値
Favorite.create(user_id: 1, tweet_id: 2)
Favorite.create(user_id: 2, tweet_id: 1)

# Relationshipsテーブル初期値
Relationship.create(following_id: 1, follower_id: 2)
Relationship.create(following_id: 2, follower_id: 1)

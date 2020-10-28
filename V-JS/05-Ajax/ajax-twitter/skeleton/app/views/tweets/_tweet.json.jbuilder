# frozen_string_literal: true

json.call(tweet, *Tweet.column_names)

json.user(tweet.user, :id, :username)

json.mentions(tweet.mentions) do |mention|
  json.call(mention, *Mention.column_names)
  json.user(mention.user, :id, :username)
end

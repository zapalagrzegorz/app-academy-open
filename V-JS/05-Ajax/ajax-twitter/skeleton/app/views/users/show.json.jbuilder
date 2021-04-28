# frozen_string_literal: true

# json.user do
json.call(@user, :id, :username)

json.tweets @user.tweets do |tweet|
  json.content tweet.content
  json.user_url url_for(tweet.user.id)
  json.username tweet.user.username
  json.created_at tweet.created_at

  tweet.mentioned_users tweet.mentioned_users do |mentioned|
    json.url url_for(mentioned_user)
    json.username mentioned.username
  end
end

json.followers @user.followers do |follower|
  json.username follower.username
end

json.followees @user.followees do |folowee|
  json.username folowee.username
end

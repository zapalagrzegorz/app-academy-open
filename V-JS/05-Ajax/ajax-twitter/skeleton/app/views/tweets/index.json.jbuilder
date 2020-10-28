# frozen_string_literal: true

# @tweets

# json.call(tweet, *Tweet.column_names)

# json.array!(@tweets) do |tweet|
@tweets.each do |tweet|
  json.set! tweet.id do
    # frozen_string_literal: true

    # tak dostaniesz kolumny z encji
    json.call(tweet, *Tweet.column_names)

    # można serializować od razu relacje modelu tj. belongs_to, has_many, has_many_through
    # # tu jest odwołanie do pola has_many modelu
    # json.mentioned_users(tweet.mentioned_users) do |user|
    #   json.extract! user, :id, :username
    # end
    # json.call(tweet.mentions, *Mention.column_names)

    # json.username tweet.user.username

    #     json.extract! tweet, :content, :user_id
    # json.call(tweet.user, :username)

    # json.mentioned_users(tweet.mentions) do |mention|
    #   json.mentioned_users(mention., *Mention.column_names)
    # end
  end
end

# end

# @tweets.each do |tweet|
#   json.set! tweet.id do
#     json.extract! tweet, :content, :user_id
#     json.username tweet.user.username
#     json.mentioned_users tweet.mentioned_users
#   end
# end

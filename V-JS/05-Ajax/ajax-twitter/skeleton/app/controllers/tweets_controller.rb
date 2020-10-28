# frozen_string_literal: true

class TweetsController < ApplicationController
  # before_action :require_logged_in!

  def index
    # prevent n+1 query
    @tweets = Tweet.includes(:user).includes(:mentions).last(10)

    # respond_to do |format|
    # format.html {  redirect_to feed_url }
    render :index
    # end
  end

  def create
    # simulate latency
    sleep(1)

    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      # ? request?
      respond_to do |format|
        format.html {  redirect_to feed_url }
        format.json { render :show }
      end
    else
      # Lazy: even respond with JSON to invalid HTML request.
      render json: @tweet.errors.full_messages, status: 422
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, mentioned_user_ids: [])
  end
end

# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    # authorship is reserved to currently logged in
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = ['Comment saved!']
    else
      flash[:errors] = @comment.errors.full_messages
    end

    # bo nie wiadomo czy na stronę goal_url(id) czy user_url(id)
    redirect_back fallback_location: users_url
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :content)
  end
end

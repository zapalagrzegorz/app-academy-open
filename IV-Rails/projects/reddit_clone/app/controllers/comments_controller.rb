# frozen_string_literal: true

class CommentsController < ApplicationController
  def show
    @comment = Comment.includes(:post).find(params[:id])
    @post_id = @comment.post.id
    #     @new_comment = @comment.child_comments.new
  end

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
    #     @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'Object successfully created'
      redirect_to @comment.post
    else
      flash[:error] = 'Something went wrong'
      redirect_to(models_path)
    end
  end

  # def downvote
  #   vote(-1)
  # end

  # def upvote
  #   vote(1)
  # end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  # def vote(direction)
  #   @comment = Comment.find(params[:id])
  #   @user_vote = @comment.user_votes.find_or_initialize_by(user: current_user)

  #   unless @user_vote.update(value: direction)
  #     flash[:errors] = @user_vote.errors.full_messages
  #   end

  #   redirect_to comment_url(@comment)
  # end
end

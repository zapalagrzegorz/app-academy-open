# frozen_string_literal: true

class CommentsController < ApplicationController
  def show
    @comment = Comment.includes(:post).find(params[:id])
    @post_id = @comment.post.id
  end

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
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

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end

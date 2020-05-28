class CommentsController < ApplicationController
  def create
    comment = Comment.create(comments_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: comment
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def user_comments
    if(params[:user_id])
      render json: Comment.where(user_id: params[:user_id])
    else
      render plain "Not found", status: :not_found
    end
  end

  def artwork_comments
    if(params[:artwork_id])
      render json: Comment.where(artwork_id: params[:artwork_id])
    else
      render plain "Not found", status: :not_found
    end
  end

  def index
    # render json: User.find(params[:user_id]).comments
    # would make two SQLs
      render json: Comment.all
  end
  
  
  # create, destroy, and index actions.
  def comments_params
    params.require(:comment).permit(:artwork_id, :user_id)
    
  end
end

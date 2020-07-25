# frozen_string_literal: true

class PostsController < ApplicationController
  #   before_action :require_signed_in!, except: [:show]
  before_action :require_author, only: %i[edit update destroy]

  def show
    @post = Post.includes(:author).find(params[:id])
    # @all_comments = @post.comments.includes(:author)
    @comments_by_parent_id = @post.comments_by_parent_id
    # includes(:author)
    # czemu to nie ściąga przynajmniej 1 poziomu?
    # @top_comments = @post.comments.includes(:author).includes(:child_comments).where(parent_comment_id: nil)
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def edit
    # post is in require_author
    @subs = Sub.all
  end

  def create
    #     @post = current_user.posts.new(post_params)
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.sub_ids.length.zero?
      flash[:error] = 'Post must be belong to at least one sub'
      @subs = Sub.all
      render 'new'
      return
    end

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to @post
    # end

    else
      flash[:error] = 'Something went wrong'
      @subs = Sub.all
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if params[:post][:sub_ids].length == 1
      flash[:error] = 'Post must be belong to at least one sub'
      @subs = Sub.all
      render 'new'
      return
    end

    if @post.update_attributes(post_params)
      flash[:success] = 'Post was successfully updated'
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to sub_path(@post.sub)
  end

  # def downvote
  #   vote(-1)
  # end

  # def upvote
  #   vote(1)
  # end

  private

  def require_author
    #   #   return if current_user.posts.find_by(id: params[:id])
    @post = Post.find(params[:id])
    return if @post.author_id == current_user.id

    flash[:error] = 'You\'re not allowed to do this'
    redirect_to root_url
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  # def require_user_owns_post!
  #   return if current_user.posts.find_by(id: params[:id])
  #   render json: 'Forbidden', status: :forbidden
  # end

  # def vote(direction)
  #   @post = Post.find(params[:id])
  #   @user_vote = @post.user_votes.find_or_initialize_by(user: current_user)

  #   unless @user_vote.update(value: direction)
  #     flash[:errors] = @user_vote.errors.full_messages
  #   end

  #   redirect_to post_url(@post)
  # end
end

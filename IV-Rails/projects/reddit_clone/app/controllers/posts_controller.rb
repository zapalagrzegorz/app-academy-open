# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_author, only: %i[edit update destroy]

  def show
    @post = Post.includes(:author).find(params[:id])
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def edit
    # post is in require_author
    @subs = Sub.all
    # jeżeli before_action może ustanowić pole dostępne na czas requestu, to treść jest zbędna
    # @post = Post.find(params[:id])
  end

  def create
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

    # debugger
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

  private

  def require_author
    @post = Post.find(params[:id])
    return if @post.author_id == current_user.id

    flash[:error] = 'You\'re not allowed to do this'
    redirect_to root_url
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end

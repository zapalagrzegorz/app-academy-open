# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    query = request.query_parameters[:username]
    if query
      render json: User.where("username LIKE :username", username: "%#{query}%" )
    else
      render json: User.all
    end
  end

  def create
    # user = User.new(params.require(:user).permit(:user_attributes_here))
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      hsh = {
        name: user[:username]
      }
      render json: hsh
    else
      render plain: 'Not found', status: :not_found
    end
  end

  # users/:id
  def update
    user = User.find_by(id: params[:id])
    # User.update

    if user
      user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user
      user.destroy
      render json: user
    else
      render plain: '', status: :not_found
    end
  end

  def favourite
    render json: User.user_favourites(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end

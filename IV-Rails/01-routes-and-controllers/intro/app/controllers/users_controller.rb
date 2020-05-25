# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    # user = User.new(params.require(:user).permit(:user_attributes_here))
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])


    if user
      hsh = {
        name: user[:name],
        email: user[:email]
      }
      render json: hsh
    else
      render plain: "Not found"
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
      render plain: "", status: :not_found
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user
      user.destroy
      render json: user
    else
      render plain: "", status: :not_found
    end

  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end

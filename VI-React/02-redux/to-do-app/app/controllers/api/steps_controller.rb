# frozen_string_literal: true

class Api::StepsController < ApplicationController
  # frozen_string_literal: true

  # def index
  #   @ = .all
  # end

  def index
    # query = request.query_parameters[:username]
    render json: Step.all, status: :ok
  end

  def show
    todo = Step.find_by(id: params[:id])

    if todo
      render json: todo
    else
      render json: ['No entity found'], status: :not_found
    end
  end

  def create
    step = Step.new(step_params)
    if step.save
      render json: step, status: :created
    else
      render json: step.errors.full_messages, status: 422
    end
  end

  def update
    step = Step.find_by(id: params[:id])
    if step
      step.update(step_params)
      render json: step
    else
      render json: ['No entity found'], status: :unprocessable_entity
    end
  end

  def destroy
    # do params'ów należy też query parametr id
    step = Step.find_by(id: params[:id])

    if step
      step.destroy
      render json: step
    else
      render json: ['No entity found'], status: :not_found
    end
  end

  def step_params
    params.require(:step).permit(:title, :done, :todo_id)
  end
end

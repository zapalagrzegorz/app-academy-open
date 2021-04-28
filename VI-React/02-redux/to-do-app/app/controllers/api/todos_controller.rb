class Api::TodosController < ApplicationController
  def index
    # query = request.query_parameters[:username]
    render json: Todo.all
  end

  def show
    todo = Todo.find_by(id: params[:id])

    if todo
      render json: todo
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
     todo = Todo.find_by(id: params[:id])
    # todo.update

    if todo
      todo.update(user_params)
      render json: todo
    else
      render json: todo.errors.full_messages, status: :unprocessable_entity
    end
  
  end

  def destroy
     todo = Todo.find_by(id: params[:id])

    if todo
      todo.destroy
      render json: todo
    else
      render plain: '', status: :not_found
    end
  end
end

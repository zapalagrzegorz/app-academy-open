# frozen_string_literal: true

class Api::TodosController < ApplicationController
  def index
    # query = request.query_parameters[:username]
    render json: Todo.all, include: :tags
  end

  def show
    todo = Todo.find_by(id: params[:id])

    if todo
      render json: todo, include: :tags, status: :ok
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, include: :tags, status: :created
    else
      render json: todo.errors.full_messages, status: 422
    end
  end

  def update
    # When you create/update a todo, Rails will automatically call tag_names= for you.
    # gdy parametrach jest tag_names: []
    todo = Todo.find_by(id: params[:id])
    if todo
      # tylko method! aktualizuje pozycje updated_at
      todo.update!(todo_params)
      # render json: todo
      # Todos should be rendered with their associated tags.
      # You can tell Rails to render associated items with the syntax render json: @todos, include: :tags.
      # This approach can get messy when including multiple associations. You will use Jbuilder in future projects to solve this problem.
      render json: @todo, include: :tags
    else
      render json: ['No entity found'], status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find_by(id: params[:id])

    if todo
      todo.destroy
      render json: todo, include: :tags
    else
      render json: ['No entity found'], status: :not_found
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :done, :id, tag_names: [])
  end
end

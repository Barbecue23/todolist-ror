class TodosController < ApplicationController
  before_action :set_todo, only: %i[toggle destroy update]
  before_action :set_filter, only: %i[index create toggle destroy update]

  def index
    @todos = Todo.filtered(@filter).ordered
    @todo = Todo.new
    @stats = stats
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path(filter: @filter) }
      end
    else
      @todos = Todo.filtered(@filter).ordered
      @stats = stats
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path(filter: @filter) }
      end
    else
      head :unprocessable_entity
    end
  end

  def toggle
    @todo.toggle!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path(filter: @filter) }
    end
  end

  def destroy
    @todo.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path(filter: @filter) }
    end
  end

  def clear_completed
    Todo.done.destroy_all
    @filter = params.fetch(:filter, "all")
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path(filter: @filter) }
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def set_filter
    @filter = params.fetch(:filter, "all")
  end

  def todo_params
    params.require(:todo).permit(:title, :priority, :completed)
  end

  def stats
    {
      total: Todo.count,
      active: Todo.active.count,
      done: Todo.done.count,
      percent: Todo.progress_percent
    }
  end
end

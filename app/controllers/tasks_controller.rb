class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy move]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @not_yet_started_tasks = Task.where(status: "not_yet_started")
    @in_progress_tasks = Task.where(status: "in_progress")
    @completed_tasks = Task.where(status: "completed")

  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end
# GET /tasks/1/edit

def edit
  respond_to do |format|
    format.html
    format.json
    format.js do
      render template: "tasks/edit.js.erb"
    end
  end
end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
        format.js do
          render template: "tasks/create.js.erb"

      #else
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
        format.js do
          render template: "tasks/update.js.erb"
        end
    end
  end
end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
      format.js do
        render template: "tasks/destroy.js.erb"
      end
    end
  end

  def move
    if @task.status == "not_yet_started"
      @task.status = "in_progress"
    elsif @task.status == "in_progress"
      @task.status = "completed"
    else
      @task.status = "in_progress"
    end
    @task.save
  
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "Task moved." }
        format.js do
          render template: "tasks/move.js.erb"

  end
end
end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:body, :status, :owner_id)
    end
end

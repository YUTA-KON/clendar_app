class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find(params[:id])
    if @plan.user_id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      redirect_to user_path(current_user)
    else
      @plans = Plan.all
      render :new
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.user_id != current_user.id
      render :show
    end
    if @plan.update(plan_params)
      redirect_to user_path(current_user), notice:"successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.user_id == current_user.id
      @plan.destroy
    end
    redirect_to user_path(current_user), notice:"successfully deleted"
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :body, :start_time, :finish_time, :start_time_dow, :finish_time_dow, :ifrepeat, :dow)
  end
end

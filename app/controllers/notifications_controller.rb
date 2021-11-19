class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
    if current_user.id != 1
      redirect_to user_path(current_user)
    end
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])
    if @notification.update(plan_params)
      redirect_to user_path(current_user), notice:"successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to user_path(current_user), notice:"successfully deleted"
  end

  private

  def notification_params
    params.require(:notification).permit(:title, :body)
  end
end

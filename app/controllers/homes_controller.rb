class HomesController < ApplicationController
  def top
    @notifications = Notification.order(created_at: :desc).limit(5)
  end
  def about
  end
end

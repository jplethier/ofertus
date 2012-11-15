class NotificationsController < AuthorizedController

  def show
    @notification.mark_as_read
    redirect_to @notification.url
  end

  def index
    @user = User.find_by_username(params[:user_id])
  end
end

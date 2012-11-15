class NotificationsController < AuthorizedController

  def show
    @notification.mark_as_read
    unless @notification.url.blank?
      redirect_to @notification.url and return
    end
    redirect_to user_notifications_path(@notification.user.username, @notification)
  end

  def index
    @user = User.find_by_username(params[:user_id])
    # verificar o porque que o cancan nao está funcionando para as actions desse controller
    if current_user != @user
      redirect_to root_path
    end

    @notifications = @notifications.paginate(:page => params[:page], :per_page => 15)
  end
end

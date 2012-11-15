class NotificationsController < AuthorizedController

  def show
    @notification.mark_as_read
    redirect_to @notification.url
  end

  def index
    @user = User.find_by_username(params[:user_id])
    # verificar o porque que o cancan nao está funcionando para as actions desse controller
    if current_user != @user
      redirect_to root_path
    end
  end
end

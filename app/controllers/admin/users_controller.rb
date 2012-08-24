class Admin::UsersController < AdminApplicationController

  def index
    @users = User.all
  end
end

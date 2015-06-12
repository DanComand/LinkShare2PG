class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to bookmarks_url, notice: "Signed Up!"
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_Name, :last_Name, :email, :password, :password_confirmation)
  end
end

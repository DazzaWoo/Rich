class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end
  def sign_in
    @user = User.new
  end
  def create
    # render html: params
    @user = User.new(user_params)
    if @user.save
      redirect_to '/', notice: "使用者新增成功"
    else
      render '/users/sign_up'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

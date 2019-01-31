class UsersController < ApplicationController
  # before_action :require_log_out, only: [:new]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    # debugger
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    render :show
  end

  def user_params
    params.require(:user).permit(:user_name, :password, :session_token) 
  end
end
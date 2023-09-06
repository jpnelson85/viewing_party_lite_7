class UsersController < ApplicationController
  before_action :require_login, only: [:dashboard, :show]

  def new
    
  end

  def show
    @user = current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to dashboard_path
    else
      flash[:alert] = "User can not be created. Please try again."
      redirect_to "/register"
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.user_name}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def dashboard
    if session[:user_id]
      user = User.find(session[:user_id])
      redirect_to user_path(user)
    else
      flash[:error] = "You must be logged in or registered to access this page."
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation)
  end
end
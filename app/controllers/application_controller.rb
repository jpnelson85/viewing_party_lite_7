class ApplicationController < ActionController::Base

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  def require_login
    unless session[:user_id]
      flash[:alert] = "You must be logged in or registered to access this page."
      redirect_to root_path
    end
  end
end

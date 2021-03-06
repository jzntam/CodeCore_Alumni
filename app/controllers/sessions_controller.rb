class SessionsController < ApplicationController
  layout "users"

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to cohorts_path, notice: "Logged in!"
    else
      flash[:alert] = "Incorrect Login Info! Have you Signed Up?"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to cohorts_path, notice: "Logged Out!"
  end

end
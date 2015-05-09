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

  def slack
    # render json: request.env["omniauth.auth"]
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end
end
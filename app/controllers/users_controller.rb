class UsersController < ApplicationController

  # Moved to Cohorts index
  # def new
  #   @user = User.new
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to cohorts_path, notice: "Successfully Registered"
    else
      flash[:alert] = "Error creating account, please try again."
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

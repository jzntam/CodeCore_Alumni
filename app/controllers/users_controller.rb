class UsersController < ApplicationController
  layout "users"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to cohorts_path, notice: "Successfully Registered"
    else
      flash[:alert] = "Error creating account, please try again."
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to cohorts_path, notice: "Log In Profile Updated"
    else
      flash[:alert] = "Error updating account, please try again."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      session[:user_id] = nil
      if @user.destroy
        redirect_to cohorts_path, notice: "Sorry to see you go... Account Deleted."
      else
        flash[:alert] = "Unable to Delete, please try again."
        render :edit
      end
    else
      flash[:alert] = "Cannot Delete an account that is not yours."
      redirect_to cohorts_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

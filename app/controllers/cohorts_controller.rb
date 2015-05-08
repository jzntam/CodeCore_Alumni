class CohortsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :new_user, only: [:index, :show]

  # PAULO: this method can be used in a lot of methods so I'm just going to update it
  # before_action :find_cohort, only: [:show]
  before_action :find_cohort, only: [:show, :edit, :update, :destroy]
  
  def index
    @cohorts = Cohort.all
    @cohort = Cohort.new
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      redirect_to cohorts_path, notice: "Alumni Group Successfully Created"
    else
      flash[:alert] = "\"#{@cohort.errors.full_messages.join(' & ')}\". Unable to create, please try again."
      redirect_to cohorts_path
      # render :new
    end
  end
  
  def show
    # using before action
    # @cohort = Cohort.find(params[:id])
  end

  def edit
    # Using before action
    # @cohort = Cohort.find(params[:id])
  end

  def update
    # using before action
    # @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      redirect_to cohorts_path, notice: "Alumni Group Updated"
    else
      flash[:alert] = "Problem"
      redirect_to cohorts_path
    end
  end

  def destroy
    # using before action
    # @cohort = Cohort.find(params[:id])
    if @cohort.destroy
      redirect_to cohorts_path, notice: "Alumni Group Deleted"
    else
      flash[:alert] = "Problem"
      redirect_to cohorts_path
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:title, :details)
  end

  def new_user
    @user = User.new
  end

  def find_cohort
    @cohort = Cohort.find params[:id]
  end
end

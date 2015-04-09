class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      redirect_to cohorts_path, notice: "Alumni Group Successfully Created"
    else
      flash[:alert] = "Problem"
      redirect_to cohorts_path
      # render :new
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      redirect_to cohorts_path, notice: "Alumni Group Updated"
    else
      flash[:alert] = "Problem"
      redirect_to cohorts_path
    end
  end

  def destroy
    @cohort = Cohort.find(params[:id])
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
end

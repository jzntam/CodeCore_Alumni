class ContactsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @cohort = Cohort.find(params[:cohort_id])
    @contact = Contact.new
  end

  def create
    @cohort = Cohort.find(params[:cohort_id])
    @contact = Contact.new(contact_params)
    @contact.cohort = @cohort
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to cohort_path(@cohort), notice: "Contact Created!"
    else
      flash[:alert] = "It looks like you already have a profile. Edit or Delete that one."
      redirect_to cohort_path(@cohort)
    end
    # render text: params
  end

  def edit
    @contact = Contact.find(params[:id])
    @cohort = Cohort.find(params[:cohort_id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to cohort_path(@contact.cohort_id), notice: "Contact Updated!"
    else
      flash[:alert] = "Could not update contact, please try again."
      redirect_to cohort_path(@contact.cohort_id)
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      redirect_to cohort_path(@contact.cohort_id), notice: "Contact Deleted!"
    else
      flash[:alert] = "Could not delete contact, please try again."
      redirect_to cohort_path(@contact.cohort_id)
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :company, :website, :other)
  end

end

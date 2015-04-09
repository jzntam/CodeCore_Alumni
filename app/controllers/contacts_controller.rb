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
      flash[:alert] = "Cannot create empty contact. Please type something."
      redirect_to cohort_path(@cohort)
    end
    # render text: params
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :company, :website, :other)
  end

end

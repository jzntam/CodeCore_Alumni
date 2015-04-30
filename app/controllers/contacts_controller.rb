class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_contact, only: [:show, :edit, :update, :destroy]
  before_action :find_cohort, only: [:new, :create, :edit]

  def index
  end

  def new
    # uses before action to find a cohort
    # @cohort = Cohort.find(params[:cohort_id])
    @contact = Contact.new
  end

  def create
    # @cohort = Cohort.find(params[:cohort_id])
    # @contact = Contact.new(contact_params)
    # @contact.cohort = @cohort
    # @contact.user_id = current_user.id => PAULO: contact uses user and not user_id. maybe a mistake?

    # uses before action to find a cohort
    # one line solution?
    @contact = @cohort.contacts.new(contact_params.merge(user: current_user))
    if @contact.save
      # if current_user.update(user_params)
        redirect_to cohort_path(@cohort), notice: "Contact Created!"
      # else
      #   flash[:alert] = "Unable to update user profile"
      #   redirect_to cohort_path(@cohort)
      # end
    else
      flash[:alert] = "It looks like you already have a profile. Edit or Delete that one."
      redirect_to cohort_path(@cohort)
    end
    # render text: params
  end

  def show
    # uses before action to find contact
  end

  def edit
    # uses before action to find contact and cohort

    # @contact = Contact.find(params[:id])
    # @cohort = Cohort.find(params[:cohort_id])
  end

  def update
    # @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      # if current_user.update(user_params)
        redirect_to cohort_path(@contact.cohort_id), notice: "Contact Updated!"
      # else
        # flash[:alert] = "Could not update profile"
        # redirect_to cohort_path(@contact.cohort_id)
      # end
    else
      flash[:alert] = "Could not update contact, please try again."
      redirect_to cohort_path(@contact.cohort_id)
    end
  end

  def destroy
    # @contact = Contact.find(params[:id])
    if @contact.destroy
      redirect_to cohort_path(@contact.cohort_id), notice: "Contact Deleted!"
    else
      flash[:alert] = "Could not delete contact, please try again."
      redirect_to cohort_path(@contact.cohort_id)
    end
  end

  private

  # def user_params
  #   params.require(:user).permit(:first_name, :last_name, :email)
  # end

  def contact_params
    # added user to store in user id.
    params.require(:contact).permit(:phone, :company, :website, :other, :user, :position, :project, :github, :linkedin)
  end

  def find_contact
    @contact = Contact.find( params[:id] )
  end

  def find_cohort
    @cohort = Cohort.find( params[:cohort_id] )
  end

end

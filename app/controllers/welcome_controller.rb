class WelcomeController < ApplicationController
  layout "landing"
  before_action :logged_in?

  def index
  end

  private

  def logged_in?
    if current_user.present?
      redirect_to cohorts_path
    end
  end

end

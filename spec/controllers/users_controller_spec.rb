require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#create" do
    def valid_request
      post :create, user: {
        first_name: "Paulo",
        last_name: "Ancheta",
        email: "paulo@paulo.com",
        password: "mysupadupasecretpassword"
      }
    end

    it "adds a new user in the database" do
      expect{valid_request}.to change {User.count}.by(1)
    end

    it "redirects to cohorts index path" do
      valid_request
      expect(response).to redirect_to(cohorts_path)
    end

    it "has a flash notice on valid request" do
      valid_request
      expect(flash[:notice]).to be
    end

    it "has a flash alert on invalid request" do
      post :create, user: {first_name: "Paulo"} # no last_name, email and password
      expect(flash[:alert]).to be
    end

    it "renders a new page on invalid request" do
      post :create, user: {first_name: "Paulo"} # no last_name, email and password
      expect(response).to render_template(:new)
    end
  end

end

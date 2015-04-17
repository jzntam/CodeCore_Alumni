require 'rails_helper'

RSpec.describe CohortsController, type: :controller do
  let(:cohort) { create(:cohort) }
  let(:cohort_1) { create(:cohort) }
  let(:user) { create(:user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns all cohorts" do
      get :index
      expect( assigns(:cohorts) ).to match_array([cohort_1, cohort])
    end

    it "renders the index templaye" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before {login(user)}
    it "returns http success" do
      get :show, id: cohort.id
      expect(response).to have_http_status(:success)
    end

    it "renders show page" do
      get :show, id: cohort.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    context "user is not signed in" do
      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context "user is signed in" do
      before {login(user)}
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      it "renders a new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #create" do
    # let(:cohort_valid_request) 
    context "User is not signed in" do
      it "returns http redirect" do
        get :create
        expect(response).to have_http_status(:redirect)
      end
    end

    context "User is signed in and creates a valid request" do
      def valid_request
        login(user)
        post :create, cohort: {title: "Some title", details: "Some detail"}
      end
      it "creates a new cohort" do
        get :create
        expect{valid_request}.to change {Cohort.count}.by(1)
      end
    end

    context "User is signed in and creates an invalid request" do
      def invalid_request
        login(user)
        post :create, cohort: {title: "", details: ""}
      end

      it "does not create a new cohort" do
        get :create
        expect{invalid_request}.to change {Cohort.count}.by(0)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      login(user)
      get :edit, id: cohort.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit page" do
      login(user)
      get :edit, id: cohort.id
      expect(response).to render_template(:edit)
    end

    it "redirects when user not signed in" do 
      get :edit, id: cohort.id
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #update" do
    before {login(user)}
    before {patch :update, id: cohort.id, cohort: {title: "edited title"}}
    it "returns http redirect" do # when cohort is updated, it redirects to root path
      # login(user)
      expect(response).to have_http_status(:redirect)
    end

    it "redirects to cohort root path" do
      login(user)
      expect(response).to redirect_to( cohorts_path )
    end
  end

  describe "GET #delete" do
    def valid_request
      login(user)
      delete :destroy, id: cohort.id
    end
    it "returns http redirect" do
      valid_request
      expect(response).to have_http_status(:redirect)
    end

    it "redirects to root path" do
      valid_request
      expect(response).to redirect_to( cohorts_path )
    end

    it "deletes the cohort in the database" do
      login(user)
      cohort
      expect{
        delete :destroy, id: cohort.id
      }.to change {Cohort.count}.by(-1)
    end

  end

end

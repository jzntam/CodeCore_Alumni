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
      expect( assigns(:cohorts) ).to eq([cohort, cohort_1])
    end

    it "renders the index templaye" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
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
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

end

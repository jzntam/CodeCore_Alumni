require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:cohort) { create(:cohort) }
  let(:contact) { create(:contact) }
  let(:user) { create(:user) }

  describe "GET #index" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before {login(user)}
    it "returns http success" do
      get :show, cohort_id: cohort.id, id: contact.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    before {login(user)}
    it "returns http success" do
      get :new, cohort_id: cohort.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before {login(user)}
    it "returns http found" do
      post :create, cohort_id: cohort.id, contact: {first_name: "John"}
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(cohort_path(cohort)) 
    end
  end

  describe "GET #edit" do
    before {login(user)}
    it "returns http success" do
      get :edit, cohort_id: cohort.id, id: contact.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    before {login(user)}
    it "returns http found" do
      cohort.contacts << contact
      patch :update, id: contact.id, cohort_id: cohort.id, contact: { first_name: "John"}
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(cohort_path(cohort)) 
    end
  end

  describe "delete #destroy" do
    before {login(user)}
    it "returns http found" do
      cohort.contacts << contact
      delete :destroy, id: contact.id, cohort_id: cohort.id, contact: { first_name: "John"}
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(cohort_path(cohort)) 
    end
  end

end

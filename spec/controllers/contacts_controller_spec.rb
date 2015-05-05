require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:cohort) { create(:cohort) }
  let(:contact) { create(:contact) }
  let(:user) { create(:user) }
  let(:contact_1) { create(:contact, user: user) }
  describe "GET #index" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    context "when user logged in" do
      before {login(user)}
      before {get :index, cohort_id: cohort.id, id: contact.id}
      it "renders the contacts index" do
        cohort.contacts << contact
        expect(response).to render_template(:index)
      end
    end
    context "when user not logged in" do
      it "redirects to sign in page" do
        get :index, cohort_id: cohort.id, id: contact.id
        expect(response).to redirect_to new_session_path
      end      
    end
  end

  describe "GET #show" do

    context "when user logged in" do
      before {login(user)}
      before { get :show, cohort_id: cohort.id, id: contact.id }
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
      it "sets and instance variable with the contact whose id is passed" do
        expect(assigns(:contact)).to eq(contact)
      end
    end

    context "when user not logged in" do
      it "redirects to sign in page" do
        get :show, cohort_id: cohort.id, id: contact.id
        expect(response).to redirect_to new_session_path
      end      
    end
  end

  describe "GET #new" do
    context "when user signed in" do
      before {login(user)}
      before {get :new, cohort_id: cohort.id}
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "renders the new template" do
        expect(response).to render_template(:new)
      end
      it "sets an instance variable to a new contact" do
        expect(assigns(:contact)).to be_a_new Contact
      end
      it "sets and instance variable with the cohort whose id is passed" do
        expect(assigns(:cohort)).to eq(cohort)
      end
    end
    context "when user not logged in" do
      it "redirects to sign in page" do
        get :new, cohort_id: cohort.id, id: contact.id
        expect(response).to redirect_to new_session_path
      end      
    end
  end

  describe "POST #create" do
    context "user signed in" do
      before { login(user) }
      it "returns http found" do
        post :create, cohort_id: cohort.id, contact: {phone: "604 333 3333" }
        expect(response).to redirect_to(cohort_path(cohort)) 
      end
      context "with valid parameters" do
        def valid_request
          post :create, cohort_id: cohort.id, contact: attributes_for(:contact)
        end
        it "creates a new contact in the database" do
          expect { valid_request }.to change {Contact.count}.by(1)
        end
        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
        it "redirects to contact show page" do
          valid_request
          expect(response).to redirect_to(cohort_path(cohort))
        end
        it "associates the created contact to the user" do
          valid_request
          expect(Contact.last.user).to eq(user)
        end
        it "associates the created contact to the cohort" do
          valid_request
          expect(Contact.last.cohort).to eq(cohort)
        end
      end
      context "with invalid parameters" do
        def invalid_request
          user.contacts.create(cohort_id: cohort, user_id: user.id, phone: "555-123-4567")
          post :create, cohort_id: cohort.id, contact: {user_id: user.id}
        end
        # it "doesnt create a record in the database" do
        #   expect {invalid_request}.to change {Campaign.count}.by(0)
        # end
        it "redirects to the cohort show page" do
          invalid_request
          expect(response).to redirect_to(cohort_path(cohort))
        end
        it "sets a flash message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end
    context "when user not logged in" do
      it "redirects to sign in page" do
        get :new, cohort_id: cohort.id, id: contact.id
        expect(response).to redirect_to new_session_path
      end      
    end
  end

  describe "GET #edit" do
    context "when user signed in" do
      before {login(user)}
      before {get :edit, cohort_id: cohort.id, id: contact.id}
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "renders the new template" do
        expect(response).to render_template(:edit)
      end
      it "sets an instance variable to a new contact" do
        expect(assigns(:contact)).to eq(contact)
      end
      it "sets and instance variable with the cohort whose id is passed" do
        expect(assigns(:cohort)).to eq(cohort)
      end
    end
    context "when user not logged in" do
      it "redirects to sign in page" do
        get :edit, cohort_id: cohort.id, id: contact.id
        expect(response).to redirect_to new_session_path
      end      
    end
  end

  describe "PATCH #update" do
    context "with owner/user signed in" do
      before { login(user) }
      def valid_attributes(new_attributes = {})
        attributes_for(:contact).merge(new_attributes)
      end
      it "returns http found" do
        cohort.contacts << contact
        patch :update, id: contact.id, cohort_id: cohort.id, contact: { first_name: "John"}
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(cohort_path(cohort)) 
      end
      context "with valid attributes" do
        before do
          cohort.contacts << contact
          patch :update, cohort_id: cohort.id, id: contact.id, contact: valid_attributes(position: "Superstar") 
        end
        it "updates the record in the database" do
          expect(contact.reload.position).to eq("Superstar")
        end
        it "redirect_to the cohort show page" do
          expect(response).to redirect_to(cohort_path(contact.cohort_id))
        end
        it "sets a flash message" do
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        before { login(user) }
        before do
          cohort.contacts << contact
          patch :update, cohort_id: cohort.id, id: contact.id, contact: {phone: 555-555-5555}
        end
        it "doesnt update the record in the database" do
          expect(contact.reload.phone).to_not eq("555-555-5555")
        end  
        it "redirect_to the cohort show page" do
          expect(response).to redirect_to(cohort_path(contact.cohort_id))
        end
      end
    end
    context "with non-owner user signed in" do
      before { login(user) }
      it "raises an error" do
        expect do
          patch :update, id: contact.id, contact: attributes_for(:contact)
        end.to raise_error
      end
    end
    context "with user not signed in" do
      it "redirects new session path" do
        cohort.contacts << contact
        patch :update, cohort_id: cohort.id, id: contact.id, contact: {position: "Superstar"}
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    context "with user signed in" do
      before { login(user) }
      it "returns http found" do
        cohort.contacts << contact
        delete :destroy, id: contact.id, cohort_id: cohort.id
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(cohort_path(cohort)) 
      end
      context "with non-owner signed in" do
        it "throws an error" do
          expect {delete :destroy, id: contact_1.id, cohort_id: cohort.id}.to raise_error
        end
      end
      context "with owner signed in" do
        it "reduces the number of contacts in the database by 1" do
          cohort.contacts << contact_1
          expect { delete :destroy, id: contact_1.id, cohort_id: cohort.id }.to change { Contact.count }.by(-1)
        end
        it "redirect_to the cohort show page" do
          cohort.contacts << contact_1
          delete :destroy, id: contact_1.id, cohort_id: cohort.id
          expect(response).to redirect_to(cohort_path(contact_1.cohort_id))
        end
        it "sets a flash message" do
          cohort.contacts << contact_1
          delete :destroy, id: contact_1.id, cohort_id: cohort.id
          expect(flash[:notice]).to be
        end
      end
    end
    context "with user not signed in" do
      it "redirect_to the sign in page" do
        cohort.contacts << contact_1
        delete :destroy, id: contact_1.id, cohort_id: cohort.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

end

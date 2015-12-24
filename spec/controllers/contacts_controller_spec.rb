require 'rails_helper'
require 'pry'

shared_examples 'public access to contacts' do
  before :each do
    @contact = create(:contact, firstname: 'Lawrence', lastname: 'Smith')
  end

  describe 'GET #index' do
    it 'populates an array of contacts' do
      get :index
      expect(response).to render_template :index
    end
  end
end

describe ContactsController do
  it_behaves_like 'public access to contacts'

  describe 'GET #show' do
    let(:contact) { create(:contact) }

    it 'assigns the requested contact to @contact' do
      get :show, id: contact
      expect(assigns(:contact)).to eq contact
    end

    it "render the show template" do
      get :show, id: contact
      expect(response).to render_template :show
    end
  end

  describe "get #index" do
    context 'with params[:letter]' do
      it "populates an array of contacts starting with the letter" do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index, letter: 'S'
        expect(assigns(:contacts)).to match_array [smith]
        expect(response).to render_template :index
      end
    end

    context "with params[:letter]" do
      it "populates an array of all contacts" do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index
        expect(assigns(:contacts)).to match_array [smith, jones]
      end

      it "rende the index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #new" do
    it "assigns a new Contact to @contact" do
      get :new
      expect(assigns(:contact)).to be_a_new Contact
    end

    it "render the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "get #exit" do
    it "assigns the requested contact to @contact" do
      contact = create(:contact)
      get :edit, id: contact
      expect(assigns(:contact)).to eq contact
    end

    it "render the edit template" do
      contact = create(:contact)
      get :edit, id: contact
      expect(response).to render_template :edit
    end
  end

  describe "post #create" do
    let(:phone) do
      [attributes_for(:phone), attributes_for(:phone), attributes_for(:phone)]
    end

    context "with valid attributes" do
      it "save the new contact in the database" do
        expect {
          post :create, contact: attributes_for(:contact, phones_attributes: phone)
        }.to change(Contact, :count).by(1).and change(Phone, :count).by(3)
      end

      it "redrect to the show template" do
        post :create, contact: attributes_for(:contact, phones_attributes: phone)
        expect(response).to redirect_to contact_path(assigns(:contact))
      end
    end

    context "use subject to test" do
      subject { create(:contact, firstname: 'Tom') }
      specify { should eq subject }
    end

    context "with invalid attributes" do
      it "does not save the new contact to database" do
        expect {
          post :create, contact: attributes_for(:invalid_contact)
        }.to_not change(Contact, :count)
      end

      it "re-render the new template" do
        post :create, contact: attributes_for(:invalid_contact)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let (:contact) { create(:contact) }
    context "valid attributes" do
      it "locates the requested @contact" do
        patch :update, id: contact, contact: attributes_for(:contact, firstname: 'Jistin')
        expect(assigns(:contact)).to eq(contact)
      end

      it "changes the attributes" do
        patch :update, id: contact, contact: attributes_for(:contact, firstname: 'Jistin')
        contact.reload
        expect(contact.firstname).to eq 'Jistin'
      end

      it "redirect to the updated contact" do
        patch :update, id: contact, contact: attributes_for(:contact, firstname: 'Jistin')
        expect(response).to redirect_to contact_path(contact)
      end
    end

    context "invalid attributes" do
      it "does not change the contact's attributes" do
        patch :update, id: contact, contact: attributes_for(:invalid_contact)
        contact.reload
        expect(contact.firstname).to eq 'Justin'
      end

      it "should render to edit template" do
        patch :update, id: contact, contact: attributes_for(:invalid_contact)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:contact) { create(:contact) }
    subject { delete :destroy, id: contact }
    it {expect{subject}.to change(Contact, :count).by(-1) }
    it { is_expected.to redirect_to contacts_url }
  end

end

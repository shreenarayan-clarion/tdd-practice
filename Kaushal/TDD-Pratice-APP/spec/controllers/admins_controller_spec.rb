require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AdminsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Admin. As you add validations to Admin, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: Faker::Name.name}
  }

  let(:invalid_attributes) {
    {name: '', email: Faker::Internet.free_email}
  }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  
  before(:each) do
    sign_in :admin, super_admin    
  end

  describe "GET #index" do
    it "assigns all admins as @admins" do
      get :index
      expect(assigns(:admins).resultset).to eq([admin])
    end
  end

  describe "GET #show" do
    it "assigns the requested admin as @admin" do
      get :show, {:id => admin.to_param}
      expect(assigns(:admin)).to eq(admin)
    end
  end

  describe "GET #new" do
    it "assigns a new admin as @admin" do
      get :new
      expect(assigns(:admin)).to be_a_new(Admin)
    end
  end

  describe "GET #edit" do
    it "assigns the requested admin as @admin" do
      get :edit, {:id => admin.to_param}
      expect(assigns(:admin)).to eq(admin)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: Faker::Name.name}
      }

      it "updates the requested admin" do
        put :update, {:id => admin.to_param, :admin => new_attributes}
        admin.reload
      end

      it "assigns the requested admin as @admin" do
        put :update, {:id => admin.to_param, :admin => valid_attributes}
        expect(assigns(:admin)).to eq(admin)
      end

      it "redirects to the admin" do
        put :update, {:id => admin.to_param, :admin => valid_attributes}
        expect(response).to redirect_to(admins_url)
      end
    end

    context "with invalid params" do
      it "assigns the admin as @admin" do
        put :update, {:id => admin.to_param, :admin => invalid_attributes}
        expect(assigns(:admin)).to eq(admin)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => admin.to_param, :admin => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin" do
      expect {
        delete :destroy, {:id => admin.to_param}
      }.to change(Admin, :count).by(0)
    end

    it "redirects to the admins list" do
      admin = FactoryGirl.create(:admin)
      delete :destroy, {:id => admin.to_param}
      expect(response).to redirect_to(admins_url)
    end
  end

end

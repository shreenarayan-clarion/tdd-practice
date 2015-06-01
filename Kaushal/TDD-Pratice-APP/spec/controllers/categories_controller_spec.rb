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

RSpec.describe CategoriesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Category. As you add validations to Category, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'Other'}
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  
  before(:each) do
    sign_in :admin, super_admin    
  end

  describe "GET #index" do
    it "assigns all categories as @categories" do
      category = FactoryGirl.create(:category, admin: super_admin)
      get :index
      expect(assigns(:categories).resultset).to eq([category])
    end
  end

  describe "GET #show" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create(:category, admin: super_admin)
      get :show, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    it "assigns a new category as @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET #edit" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create(:category, admin: super_admin)
      get :edit, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}
        expect(response).to redirect_to(categories_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, {:category => invalid_attributes}
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, {:category => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "Design", admin_id: super_admin.id}
      }

      it "updates the requested category" do
        category = FactoryGirl.create(:category, admin: super_admin)
        put :update, {:id => category.to_param, :category => new_attributes}
        category.reload
      end

      it "assigns the requested category as @category" do
        category = FactoryGirl.create(:category, admin: super_admin)
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = FactoryGirl.create(:category, admin: super_admin)
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(response).to redirect_to(categories_url)
      end
    end

    context "with invalid params" do
      it "assigns the category as @category" do
        category = FactoryGirl.create(:category, admin: super_admin)
        put :update, {:id => category.to_param, :category => invalid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = FactoryGirl.create(:category, admin: super_admin)
        put :update, {:id => category.to_param, :category => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = FactoryGirl.create(:category, admin: super_admin)
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = FactoryGirl.create(:category, admin: super_admin)
      delete :destroy, {:id => category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end

end
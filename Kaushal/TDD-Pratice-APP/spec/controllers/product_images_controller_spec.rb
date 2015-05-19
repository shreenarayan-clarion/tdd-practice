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

RSpec.describe ProductImagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # ProductImage. As you add validations to ProductImage, be sure to
  # adjust the attributes here as well.
  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:category) { FactoryGirl.create(:category, admin: super_admin) }
  let(:product) {FactoryGirl.create(:product, admin: super_admin)}

  let(:valid_attributes) {
    {image: Rack::Test::UploadedFile.new("#{Rails.root.to_s}/public/default_images/Featured_single_SIDE.76.png", 'image/png'), image_content_type: 'Image/jpeg',admin_id: super_admin.id, category_id: category.id, product_id: product.id}
  }

  let(:invalid_attributes) {
    {image: nil}
  }

  
  before(:each) do
    sign_in :admin, super_admin    
  end

  describe "GET #index" do
    it "assigns all product_images as @product_images" do
      product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
      get :index, product_id: product.id
      expect(assigns(:product_images).resultset).to eq([product_image])
    end
  end

  describe "GET #show" do
    it "assigns the requested product_image as @product_image" do
      product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
      get :show, {:id => product_image.to_param, product_id: product.id}
      expect(assigns(:product_image)).to eq(product_image)
    end
  end

  describe "GET #new" do
    it "assigns a new product_image as @product_image" do
      get :new, product_id: product.id
      expect(assigns(:product_image)).to be_a_new(ProductImage)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product_image as @product_image" do
      product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
      get :edit, {:id => product_image.to_param, product_id: product.id}
      expect(assigns(:product_image)).to eq(product_image)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ProductImage" do
        expect {
          post :create, {:product_image => valid_attributes, product_id: product.id}
        }.to change(ProductImage, :count).by(1)
      end

      it "assigns a newly created product_image as @product_image" do
        post :create, {:product_image => valid_attributes, product_id: product.id}
        expect(assigns(:product_image)).to be_a(ProductImage)
        expect(assigns(:product_image)).to be_persisted
      end

      it "redirects to the created product_image" do
        post :create, {:product_image => valid_attributes, product_id: product.id}
        expect(response).to redirect_to(product_product_images_url(product))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product_image as @product_image" do
        post :create, {:product_image => invalid_attributes, product_id: product.id}
        expect(assigns(:product_image)).to be_a_new(ProductImage)
      end

      it "re-renders the 'new' template" do
        post :create, {:product_image => invalid_attributes, product_id: product.id}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {image: Rack::Test::UploadedFile.new("#{Rails.root.to_s}/public/default_images/Featured_single_SIDE.76.png", 'image/png'), admin_id: super_admin.id}
      }

      it "updates the requested product_image" do
        product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
        put :update, {:id => product_image.to_param, :product_image => new_attributes, product_id: product.id}
        product_image.reload
      end

      it "assigns the requested product_image as @product_image" do
        product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
        put :update, {:id => product_image.to_param, :product_image => valid_attributes, product_id: product.id}
        expect(assigns(:product_image)).to eq(product_image)
      end

      it "redirects to the product_image" do
        product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
        put :update, {:id => product_image.to_param, :product_image => valid_attributes, product_id: product.id}
        expect(response).to redirect_to(product_product_images_url(product_image.product))
      end
    end

    context "with invalid params" do
      it "assigns the product_image as @product_image" do
        product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
        put :update, {:id => product_image.to_param, :product_image => invalid_attributes, product_id: product.id}
        expect(assigns(:product_image)).to eq(product_image)
      end

      it "re-renders the 'edit' template" do
        product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
        put :update, {:id => product_image.to_param, :product_image => invalid_attributes, product_id: product.id}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product_image" do
      product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
      expect {
        delete :destroy, {:id => product_image.to_param, product_id: product.id}
      }.to change(ProductImage, :count).by(-1)
    end

    it "redirects to the product_images list" do
      product_image = FactoryGirl.create(:product_image, admin: super_admin, product: product, category: category)
      delete :destroy, {:id => product_image.to_param, product_id: product.id}
      expect(response).to redirect_to(product_product_images_url(product_image.product))
    end
  end

end

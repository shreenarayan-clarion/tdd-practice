require 'spec_helper'

RSpec.describe UsersController  do

  describe "GET #index" do

    before do
      get :index
    end

    it "render index template" do
      expect(response).to render_template(:index)
    end

    it "return the user listing" do
      users = FactoryGirl.create(:user)
      assigns(:users).should eq(User.all)
    end
  end

  describe "GET #new" do

    before { get :new }

    it "create a new instance of User" do
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "render the :new template" do
      expect(response).to render_template :new
    end

  end

  describe "Post #create" do

    context "with valid attributes" do

      before { @user = attributes_for(:user) }

      it "create a new user" do
        expect{ post :create, user: @user }.to change { User.count }.by(1)
      end

      it "redirect to user show page" do
        post :create, user: @user
        expect(response).to redirect_to User.last
      end
    end

    context "With invalid attributes" do

      before { @invalid_user = attributes_for(:invalid_user) }

      it "will not create a new user" do
        expect{ post :create, user: @invalid_user }.to_not change{ User.count }.by(1)
      end

      it "re-render the new page" do
        post :create, user: @invalid_user
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #show" do

    before do
      @user = create(:user)
      get :show, id: @user
    end

    it "render the user show template" do
      expect(response).to render_template :show
    end

    it "assign requested user value in the @user varible" do
      expect(assigns(:user)).to eq(@user)
    end

  end

  describe "GET #edit" do

    before do
      @user = create(:user)
      get :edit, id: @user
    end

    it "return record of the requested user" do
      expect(assigns(:user)).to eq(@user)
    end

    it "render the edit template" do
      expect(response).to render_template :edit
    end

  end

  describe "PUT #update" do

    before :each do
      @user = create(:user)
    end

    context "with valid attributes" do

      it "assign the requested user" do
        put :update, id: @user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "updtae the user information" do
        put :update, id: @user, user: attributes_for(:user, name: "Anand", city: "Satna")
        @user.reload
        expect(@user.name).to eq("Anand")
      end

    end

    context "with invalid information" do

      before do
        put :update, id: @user, user: attributes_for(:user, name: "", city: "new city")
      end

      it "re render the edit template" do
        expect(response).to render_template :edit
      end

      it "is not update the user account" do
        @user.reload
        expect(@user.city).not_to eq("new city")
      end
    end
  end

  describe "DELETE #destroy" do

    before do
      @user = create(:user)
    end

    it "delete the requested user account" do
      expect { delete :destroy, id: @user }.to change { User.count }.by(-1)
    end

    it "redirects to user#index page" do
      delete :destroy, id: @user
      expect(response).to redirect_to users_url
    end

  end
end
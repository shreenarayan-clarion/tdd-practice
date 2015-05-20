require 'spec_helper'

describe UsersController do
 
  describe "GET #index" do
    it "populates an array of users" do
      user = create(:user_new) 
      get :index 
      assigns(:users).should eq([user]) 
    end
    it "renders the :index view" do 
      get :index 
      response.should render_template :index 
    end
  end

  describe "GET #new" do       
    it "assigns a new user as @user" do
      get :new, {}
      assigns(:user).should be_a_new(User)
    end
  end

  describe "USER create" do
    context "with valid attributes" do 
      it "creates a new user" do 
        expect{ 
          post :create, user: FactoryGirl.attributes_for(:user_new) 
        }.to change(User,:count).by(1) 
      end
      it "redirects to the new user" do 
        post :create, user: FactoryGirl.attributes_for(:user_new) 
        response.should redirect_to users_url 
      end 
    end 

    context "with invalid attributes" do 
      it "does not save the new user" do 
        expect{ post :create, user: FactoryGirl.attributes_for(:invalid_user) }.to_not change(User,:count) 
      end 
      it "re-renders the new method" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user) 
        response.should render_template :new 
      end 
    end 
  end

  describe 'PUT update' do 
    before :each do 
      @user = FactoryGirl.create(:user, name: "Aayush Prajapati", email: "aayush@gmail.com", password: "passW0rD", admin: false) 
    end 
    context "valid attributes" do 
      it "located the requested @user" do 
        put :update, id: @user, user: FactoryGirl.attributes_for(:user_new) 
        assigns(:user).should eq(@user) 
      end 
      it "changes @user's attributes" do 
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Aayush", email: "aayush_K@gmail.com") 
        @user.reload 
        @user.name.should eq("Aayush") 
        @user.email.should eq("aayush_K@gmail.com")
      end 
      it "redirects to the updated user" do 
        put :update, id: @user, user: FactoryGirl.attributes_for(:user_new) 
        response.should redirect_to users_url 
      end 
    end
    context "invalid attributes" do 
      it "locates the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        assigns(:user).should eq(@user) 
      end
      it "does not change @user's attributes" do 
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "") 
        @user.reload
        @user.name.should eq("Aayush Prajapati") 
        @user.email.should eq("aayush@gmail.com") 
      end
      it "re-renders the edit method" do 
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user) 
        response.should render_template :edit 
      end 
    end 
  end

  describe 'DELETE destroy' do 
    before :each do 
      @user = FactoryGirl.create(:user) 
    end
    it "deletes the user" do
      expect{ delete :destroy, id: @user }.to change(User,:count).by(-1) 
    end 
    it "redirects to users#index" do 
      delete :destroy, id: @user 
      response.should redirect_to users_url
    end
  end

end

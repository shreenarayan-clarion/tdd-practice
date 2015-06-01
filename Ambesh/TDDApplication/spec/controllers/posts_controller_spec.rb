require 'spec_helper'

describe PostsController do

  let(:user) { FactoryGirl.create(:user) }

  let(:valid_attributes) { { title: "Ambesh Kumar", content: "This is content.", user_id: user.id } }
  let(:invalid_attributes) { { title: "", content: "This is content." } }


  before(:each) do
    request.env["HTTP_REFERER"] = "back_request_url"
    request.env['warden'] = double(Warden, :authenticate => user,
                                           :authenticate! => user,
                                           :authenticate? => true)

    controller.stub :current_user => user
  end
  
  describe "GET index" do
    it "assigns all posts as @posts" do
      post = FactoryGirl.create(:post)
      get :index, {}
      assigns(:posts).should eq([post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :show, {:id => post.to_param}
      assigns(:post).should eq(post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new, {}
      assigns(:post).should be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :edit, {:id => post.to_param}
      assigns(:post).should eq(post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {:post => valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}
        response.should redirect_to(Post.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        post = FactoryGirl.create(:post)
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => post.to_param, :post => { "title" => "MyString" }}
      end

      it "assigns the requested post as @post" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => valid_attributes}
        assigns(:post).should eq(post)
      end

      it "redirects to the post" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => valid_attributes}
        response.should redirect_to(post)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        post = FactoryGirl.create(:post)
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post.to_param, :post => { "title" => "invalid value" }}
        assigns(:post).should eq(post)
      end

      it "re-renders the 'edit' template" do
        post = FactoryGirl.create(:post)
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post.to_param, :post => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      post = FactoryGirl.create(:post)
      expect {
        delete :destroy, {:id => post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = FactoryGirl.create(:post)
      delete :destroy, {:id => post.to_param}
      response.should redirect_to(posts_url)
    end
  end
end
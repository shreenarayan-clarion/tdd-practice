require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit  "/users/#{user.id}"}

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end


  describe "signup page" do
    before { visit '/signup' }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup page" do
     before { visit '/signup' }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit '/signup' }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { valid_signin(user) }

    describe "page" do
      it { should have_link("Edit Profile") }
      before { click_link "Edit Profile" }

      describe "with invalid information" do
        before { click_button "Save changes" }
        it { should have_selector('div.alert.alert-error') }
      end

      describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end
        it { should have_title(new_name) }
        it { expect(user.reload.email). to eql(new_email) }
        it { should have_selector('div.alert.alert-success')}
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    let!(:micropost1) { FactoryGirl.create(:micropost, user: user, content: "Post 1") }
    let!(:micropost2) { FactoryGirl.create(:micropost, user: user, content: "Post 2") }

    before { visit user_path(user) }
    it { should have_content(user.name) }

    describe "posts" do
      it { should have_content(user.microposts.count) }
      it { should have_content(micropost1.content) }
      it { should have_content(micropost2.content) }
    end

    describe "No post" do
      before { user.microposts.destroy_all }
      it { expect(user.microposts.count).to eq(0) }
      it { should have_content("No Post") }
    end

    describe "post destroy link" do
      let(:second_user) { FactoryGirl.create(:user, email: 'fake@gmail.com') }
      let!(:micropost_of_second_user) { FactoryGirl.create(:micropost, user: second_user) }
      before { valid_signin(second_user) }

      it "should only visible for post owner" do
        visit user_path(second_user)
        expect(page).to have_link('Destroy')
        expect(page).to have_link('Edit Profile')
      end

      it "Should not visible to non authorized user" do
        visit user_path(user)
        expect(page).not_to have_link('destroy')
      end

    end
  end
end
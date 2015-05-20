require 'spec_helper'

describe "Micropost pages" do
  let(:user) { FactoryGirl.create(:user) }

  before { valid_signin(user) }
  before { visit root_path }

  describe "Micropost creation" do
    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_selector('textarea') }

    describe "with invalid information" do
      it "should not create a new micropost" do
        expect { click_button "Post" }.not_to change { Micropost.count }
        expect(page).to have_selector('div.alert.alert-error')
      end
    end

    describe "with valid information" do
      it "should create a new post" do
        fill_in "micropost_content", with: "Hello Everyone this is testing"
        expect { click_button "Post" }.to change { Micropost.count }.by(1)
        expect(page).to have_content("Micropost successfully created!")
      end
    end
  end

  describe "micropost Destroy" do
    let!(:micropost) { FactoryGirl.create(:micropost, user: user) }
    before { visit user_path(user) }
    it { expect { click_link "Destroy" }.to change { Micropost.count }.by(-1) }
  end
end
require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end

  subject { @user }

  describe "database schema" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:contact_no).of_type(:string) }
    it { should have_db_column(:address).of_type(:text) }
    it { should have_db_column(:email).of_type(:string).with_options(default: "",null: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(default: "" , null: false) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0,null: false) }
    it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:current_sign_in_ip).of_type(:string)}
    it { should have_db_column(:last_sign_in_ip).of_type(:string)}
    it { should have_db_column(:created_at).of_type(:datetime)}
    it { should have_db_column(:updated_at).of_type(:datetime)}
  end

	describe "Validations" do
	  it { should validate_presence_of(:name) }
	  it { should ensure_length_of(:name).on(:update).is_at_most(50) }
	  it { should validate_presence_of(:address) }
	  it { should validate_presence_of(:contact_no) }
  end

  describe "Association" do
    it { should have_many(:posts) }
  end

  context "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      @user.email = "ambesh.com"
      expect(@user).should_not be_valid
    end
  end
 
  context "when email format is valid" do
    it "should be valid" do
      @user.email = "ambesh@gmail.com"
      expect(@user).to be_valid
    end
  end
end
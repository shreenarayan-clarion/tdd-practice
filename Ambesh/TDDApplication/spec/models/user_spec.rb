require 'spec_helper'

describe User do

  before do
    @user = build(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { is_expected.to respond_to(:name) }  ## Latest ###
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:microposts) }

  # ### see how shoulda matchers make your validation clean and easy ###
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_uniqueness_of(:email) }

  ### we have check association for micropost ###
  it { should have_many(:microposts)}
  ### see how shoulda matchers make your validation clean and easy ###

  it { should be_valid }

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
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "when email address is already taken" do
     before do
       user_with_same_email = @user.dup
       user_with_same_email.email = @user.email.upcase
       user_with_same_email.save
     end

     it { should_not be_valid }
  end

  context "when password is not present" do
    before do
      @user = build(:user, name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  context "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  context "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

   describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user = create(:user, email: mixed_case_email)
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    it { expect(@user.remember_token).not_to be_blank }
  end
end
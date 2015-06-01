require 'rails_helper'

RSpec.describe Admin, type: :model do
  before(:each) {
    @super_admin = FactoryGirl.create(:super_admin)
    @admin = FactoryGirl.create(:admin, created_by_id: @super_admin)
  }

  describe "database schema" do
    it { should have_db_column(:email).of_type(:string)}
    it { should have_db_column(:name).of_type(:string)}
    it { should have_db_column(:sign_in_count).of_type(:integer)}
    it { should have_db_column(:last_sign_in_ip).of_type(:string)}
    it { should have_db_column(:confirmation_token).of_type(:string)}
    it { should have_db_column(:invitation_sent_at).of_type(:datetime)}
    it { should have_db_column(:invited_by_id).of_type(:integer) }
  end

  describe "Associations" do
    it { should have_many(:own_users)}
    it { should have_many(:categories)}
    it { should have_many(:product_images)}
    it { should have_many(:products)}
    it { should belong_to(:created_by)}
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end

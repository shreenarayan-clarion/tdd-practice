require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) {
    @super_admin = FactoryGirl.create(:super_admin)
    @category = FactoryGirl.create(:category, admin: @super_admin)
  }

  describe "database schema" do
    it { should have_db_column(:name).of_type(:string)}
  end

  describe "Associations" do
    it { should have_many(:product_images)}
    it { should belong_to(:admin)}
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end

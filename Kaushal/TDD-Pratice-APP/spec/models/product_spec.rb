require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) {
    @super_admin = FactoryGirl.create(:super_admin)
    @product = FactoryGirl.create(:product, admin: @super_admin)
  }

  describe "database schema" do
    it { should have_db_column(:name).of_type(:string)}
    it { should have_db_column(:shopify_product_id).of_type(:string)}
    it { should have_db_column(:image).of_type(:string)}
    it { should have_db_column(:base_price).of_type(:float)}
    it { should have_db_column(:description).of_type(:text)}
    it { should have_db_column(:active).of_type(:boolean)}
    it { should have_db_column(:parent_id).of_type(:integer) }
    it { should have_db_column(:admin_id).of_type(:integer) }
  end

  describe "Associations" do
    it { should have_many(:components)}
    it { should have_many(:product_images)}
    it { should belong_to(:admin)}
    it { should belong_to(:parent)}
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:shopify_product_id) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:base_price) }    
    it { should validate_length_of(:name).is_at_most(50) }
  end
end
require 'rails_helper'

RSpec.describe ProductImage, type: :model do
  before(:each) {
    @super_admin = FactoryGirl.create(:super_admin)
    @product = FactoryGirl.create(:product, admin: @super_admin)
    @product_image = FactoryGirl.create(:product_image, product: @product, admin: @super_admin)
  }

  describe "database schema" do
    it { should have_db_column(:category_id).of_type(:integer)}
    it { should have_db_column(:image_file_name).of_type(:string)}
    it { should have_db_column(:image_content_type).of_type(:string)}
    it { should have_db_column(:image_file_size).of_type(:integer)}
    it { should have_db_column(:image_updated_at).of_type(:datetime)}
    it { should have_db_column(:product_id).of_type(:integer) }
    it { should have_db_column(:admin_id).of_type(:integer) }
  end

  describe "Associations" do
    it { should belong_to(:product)}
    it { should belong_to(:admin)}
    it { should belong_to(:category)}
  end

  describe "Validations" do
    it { should have_attached_file(:image) }
    it { should validate_presence_of(:image) }
    it { should validate_attachment_content_type(:image).allowing('image/png', 'image/jpeg') }
    it { should validate_presence_of(:product) }
  end
end
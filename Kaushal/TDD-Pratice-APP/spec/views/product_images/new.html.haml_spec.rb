require 'rails_helper'

RSpec.describe "product_images/new", type: :view do
  before(:each) do
    assign(:product_image, ProductImage.new(
      :product_id => 1,
      :category_id => 1,
      :image_height => 1,
      :image_width => 1,
      :image_x => 1,
      :image_y => 1,
      :product_theme_id => 1,
      :admin_id => 1
    ))
  end

  it "renders new product_image form" do
    render

    assert_select "form[action=?][method=?]", product_images_path, "post" do

      assert_select "input#product_image_product_id[name=?]", "product_image[product_id]"

      assert_select "input#product_image_category_id[name=?]", "product_image[category_id]"

      assert_select "input#product_image_image_height[name=?]", "product_image[image_height]"

      assert_select "input#product_image_image_width[name=?]", "product_image[image_width]"

      assert_select "input#product_image_image_x[name=?]", "product_image[image_x]"

      assert_select "input#product_image_image_y[name=?]", "product_image[image_y]"

      assert_select "input#product_image_product_theme_id[name=?]", "product_image[product_theme_id]"

      assert_select "input#product_image_admin_id[name=?]", "product_image[admin_id]"
    end
  end
end

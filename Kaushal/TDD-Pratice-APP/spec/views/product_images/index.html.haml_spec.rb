require 'rails_helper'

RSpec.describe "product_images/index", type: :view do
  before(:each) do
    assign(:product_images, [
      ProductImage.create!(
        :product_id => 1,
        :category_id => 2,
        :image_height => 3,
        :image_width => 4,
        :image_x => 5,
        :image_y => 6,
        :product_theme_id => 7,
        :admin_id => 8
      ),
      ProductImage.create!(
        :product_id => 1,
        :category_id => 2,
        :image_height => 3,
        :image_width => 4,
        :image_x => 5,
        :image_y => 6,
        :product_theme_id => 7,
        :admin_id => 8
      )
    ])
  end

  it "renders a list of product_images" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
  end
end

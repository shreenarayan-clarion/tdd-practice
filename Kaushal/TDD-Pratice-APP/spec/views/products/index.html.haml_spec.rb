require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :id => 1,
        :shopify_product_id => "Shopify Product",
        :name => "Name",
        :base_price => 1.5,
        :image => "Image",
        :description => "MyText",
        :active => false,
        :admin_id => 2
      ),
      Product.create!(
        :id => 1,
        :shopify_product_id => "Shopify Product",
        :name => "Name",
        :base_price => 1.5,
        :image => "Image",
        :description => "MyText",
        :active => false,
        :admin_id => 2
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Shopify Product".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

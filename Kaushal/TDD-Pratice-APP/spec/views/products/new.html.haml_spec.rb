require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :id => 1,
      :shopify_product_id => "MyString",
      :name => "MyString",
      :base_price => 1.5,
      :image => "MyString",
      :description => "MyText",
      :active => false,
      :admin_id => 1
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_id[name=?]", "product[id]"

      assert_select "input#product_shopify_product_id[name=?]", "product[shopify_product_id]"

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_base_price[name=?]", "product[base_price]"

      assert_select "input#product_image[name=?]", "product[image]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_active[name=?]", "product[active]"

      assert_select "input#product_admin_id[name=?]", "product[admin_id]"
    end
  end
end

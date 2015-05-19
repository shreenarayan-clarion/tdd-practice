require 'rails_helper'

RSpec.describe "product_comps/new", type: :view do
  before(:each) do
    assign(:product_comp, ProductComp.new())
  end

  it "renders new product_comp form" do
    render

    assert_select "form[action=?][method=?]", product_comps_path, "post" do
    end
  end
end

require 'rails_helper'

RSpec.describe "product_comps/edit", type: :view do
  before(:each) do
    @product_comp = assign(:product_comp, ProductComp.create!())
  end

  it "renders the edit product_comp form" do
    render

    assert_select "form[action=?][method=?]", product_comp_path(@product_comp), "post" do
    end
  end
end

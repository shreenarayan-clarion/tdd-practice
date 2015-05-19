require 'rails_helper'

RSpec.describe "product_comps/show", type: :view do
  before(:each) do
    @product_comp = assign(:product_comp, ProductComp.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

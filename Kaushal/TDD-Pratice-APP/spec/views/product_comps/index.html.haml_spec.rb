require 'rails_helper'

RSpec.describe "product_comps/index", type: :view do
  before(:each) do
    assign(:product_comps, [
      ProductComp.create!(),
      ProductComp.create!()
    ])
  end

  it "renders a list of product_comps" do
    render
  end
end

require 'rails_helper'

RSpec.describe "product_images/show", type: :view do
  before(:each) do
    @product_image = assign(:product_image, ProductImage.create!(
      :product_id => 1,
      :category_id => 2,
      :image_height => 3,
      :image_width => 4,
      :image_x => 5,
      :image_y => 6,
      :product_theme_id => 7,
      :admin_id => 8
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
  end
end

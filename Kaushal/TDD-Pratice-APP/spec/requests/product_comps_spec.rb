require 'rails_helper'

RSpec.describe "ProductComps", type: :request do
  describe "GET /product_comps" do
    it "works! (now write some real specs)" do
      get product_comps_path
      expect(response).to have_http_status(200)
    end
  end
end

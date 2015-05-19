require "rails_helper"

RSpec.describe ProductCompsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_comps").to route_to("product_comps#index")
    end

    it "routes to #new" do
      expect(:get => "/product_comps/new").to route_to("product_comps#new")
    end

    it "routes to #show" do
      expect(:get => "/product_comps/1").to route_to("product_comps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_comps/1/edit").to route_to("product_comps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_comps").to route_to("product_comps#create")
    end

    it "routes to #update" do
      expect(:put => "/product_comps/1").to route_to("product_comps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_comps/1").to route_to("product_comps#destroy", :id => "1")
    end

  end
end

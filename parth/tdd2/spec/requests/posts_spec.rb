require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      person = create(:person)
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get person_posts_path(person)
      response.status.should be(200)
    end
  end
end

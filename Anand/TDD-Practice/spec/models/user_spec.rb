require 'spec_helper'

describe User do
  it { expect(true).to be_truthy }

  describe "use of factory-girl" do
    context "When we create an user with factory" do
      it "should add a new record in users table" do
        expect { create(:user) } .to change { User.count }.by(1)
      end
    end
  end
end

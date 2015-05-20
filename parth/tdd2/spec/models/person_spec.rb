require 'spec_helper'

describe Person do

  # Validation tests
  # Presence valication tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  # Uniqueness validation tests
  it { should validate_uniqueness_of(:name) }

  # Length validation tests
  it { should validate_length_of(:name).on(:update).is_at_least(5) }
  it { should validate_length_of(:name).on(:update).is_at_most(30) }

  # Format validation tests
  it { should allow_value('test@example.com').for(:email) }
  it { should_not allow_value('test@example').for(:email) }
  it { should_not allow_value('test').for(:email) }

  # Association validation tests
  it { should have_many(:posts) }

  # Respond checking
  before :all do
    @person = create(:person)
  end

  subject { @person }

  it "should respond to name" do
    should respond_to(:name)
  end

  it "should respond to email" do
    should respond_to(:email)
  end

  # Person with multiple posts
  it "should have posts when created with factory" do
    # person = create(:person)

    # puts person.inspect
    # puts person.posts.count

    person_with_posts = create(:person_with_posts)

    puts person_with_posts.inspect
    # puts person_with_posts.posts.inspect
  end

end

require 'spec_helper'

describe Post do

  # Validation tests
  # Presence validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  # Uniqueness validation tests
  it { should validate_uniqueness_of(:title).scoped_to(:person_id) }

  # Length validation tests
  it { should validate_length_of(:title).on(:update).is_at_least(5) }
  it { should validate_length_of(:description).on(:update).is_at_least(20) }

  # Association tests
  it { should belong_to(:person) }

end

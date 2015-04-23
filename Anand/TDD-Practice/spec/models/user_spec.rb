require 'spec_helper'

describe User do

  [:name, :email, :password, :city].each do |attribute|
    it { is_expected.to validate_presence_of(attribute) }
  end

  it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(50) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }
  it { is_expected.to validate_confirmation_of(:password) }

  ["example@gmail.com", "example_second@gmail.com", "example.second@gmail.com",
    "example.second123@gmail.com", "4@gmail.com", "4example@gmail.com", "example4_@gmail.com",
    'example555@com5.br' ].each do |valid_email|

      it { is_expected.to allow_value(valid_email).for(:email) }
  end

  ["example.com", "exxample@gmail", 'example#.com.br', 'example@.com5', "example.second",
    'example#second@.com'].each do |invalid_email|

      it { is_expected.not_to allow_value(invalid_email).for(:email) }
  end

end

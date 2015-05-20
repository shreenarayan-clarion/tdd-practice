class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, unless: Proc.new { |u| u.email.blank? }
  validates_length_of :password, :minimum => 4, maximum: 20
end

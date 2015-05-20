class Person < ActiveRecord::Base

  # Validations
  validates :name, :presence => true, :uniqueness => :name, :length => { :minimum => 5, :maximum => 30 }
  validates :email, :presence => true, :format => { :with => /([\w\.\-_]+)?\w+@[\w-_]+(\.\w+){1,}/ }

  # Associations
  has_many :posts

  def greet_name
    name.capitalize + "!"
  end

end

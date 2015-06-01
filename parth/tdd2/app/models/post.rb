class Post < ActiveRecord::Base

  # Validations
  validates :title, :presence => true, :uniqueness => { :scope => :person_id }, :length => { :minimum => 5 }
  validates :description, :presence => true, :length => { :minimum => 20 }

  # Associations
  belongs_to :person

end

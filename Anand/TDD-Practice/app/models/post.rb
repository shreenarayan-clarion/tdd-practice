class Post < ActiveRecord::Base
  ##############Associations##########
  belongs_to :user

  #############Validations############
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10, maximum:250 }
end

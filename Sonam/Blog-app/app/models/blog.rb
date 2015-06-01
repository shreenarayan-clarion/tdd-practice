class Blog < ActiveRecord::Base
  belongs_to :user

  #########Validations##############
  validates :title, presence: true, length: { minimum: 5  }
  validates :content, presence: true, length: { maximum: 150 }
end

class SoftwareProduct < ActiveRecord::Base

  # Association
  belongs_to :device_category

  # Validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME }
  validates :description, format: { with: VALID_DESCRIPTION }, allow_blank: true

end

class Upload < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: "application/pdf" ,message: "Upload only PDF files."}
end
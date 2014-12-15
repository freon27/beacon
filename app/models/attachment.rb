class Attachment < ActiveRecord::Base
  belongs_to :request
  has_attached_file :file, :styles => { :original => "250x250>" }
  validates_attachment_file_name :file, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /doc\Z/, /pdf\Z/]
  before_post_process :allow_only_images
  
  def allow_only_images
    if !(file.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
      return false 
    end
  end 
    
    
end

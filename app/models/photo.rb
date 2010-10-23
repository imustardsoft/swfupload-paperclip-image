require 'mime/types'
class Photo < ActiveRecord::Base

  has_attached_file :file, :styles => {:medium => ["100x100>"], :thumb => ["50x50>"]},
    :url => "/attachment/:create_time_:file_image_name.:extension"
  validates_attachment_content_type :file, :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png', 'image/bmp', 'image/gif']
  validates_attachment_size :file, :less_than => 3.megabytes

  Paperclip.interpolates :file_image_name do |attachment, style|
    ( (style == :medium)? 'medium' : ((style == :thumb)? 'thumb' : 'original') )
  end

  Paperclip.interpolates :create_time do |attachment, style|
    attachment.instance.create_time
  end

  def create_time
    self.created_at.strftime('%Y%m%d%H%M%S')
  end

  def swfupload_file=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.file = data
  end
end

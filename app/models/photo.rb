class Photo < ApplicationRecord
  acts_as_taggable
  
  mount_uploader :image, ImagesUploader
  skip_callback :commit, :after, :remove_image!
end

class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  acts_as_taggable

  validates :image, presence: true
end

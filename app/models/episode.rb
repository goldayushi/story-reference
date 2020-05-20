# frozen_string_literal: true

class Episode < ApplicationRecord
  acts_as_taggable

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :set, length: { maximum: 50 }
  validates :division, length: { maximum: 50 }
end

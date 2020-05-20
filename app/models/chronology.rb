# frozen_string_literal: true

class Chronology < ApplicationRecord
  validates :year, presence: true, uniqueness: true
end

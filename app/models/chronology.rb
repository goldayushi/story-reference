class Chronology < ApplicationRecord
	validates :year, presence: true, uniqueness: true
end

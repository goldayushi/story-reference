class Character < ApplicationRecord
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :role, presence: false, length: { maximum: 50 }
	validates :position, length: { maximum: 100 }
	validates :countory, length: { maximum: 50 }
	validates :birthplace, length: { maximum: 50 }
end

class Glossary < ApplicationRecord
	acts_as_taggable

	validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
end

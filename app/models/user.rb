class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true, on: :create
	validates :password, presence: true, on: :create
end
# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

	validates :name, presence: true, uniqueness: true, on: :create
	validates :password, presence: true, on: :create
end

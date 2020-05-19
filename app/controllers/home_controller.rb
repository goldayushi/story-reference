# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :logged_in_user

  def top; end
end

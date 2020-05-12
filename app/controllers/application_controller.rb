class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :admin_user?, :logged_in?

  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end

    def admin_user?
      unless @current_user.nil?
        return @current_user.admin
      end
    end

    def not_admin_user
      unless admin_user?
        redirect_to root_path
      end
    end
end
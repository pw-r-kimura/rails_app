ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

  # $B%F%9%H%f!<%6!<$,%m%0%$%sCf$N>l9g$K(Btrue$B$rJV$9(B
  def is_logged_in?
    !session[:user_id].nil?
  end

  # $B%F%9%H%f!<%6!<$H$7$F%m%0%$%s$9$k(B
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest

  # $B%F%9%H%f!<%6!<$H$7$F%m%0%$%s$9$k(B
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end

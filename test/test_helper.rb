ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  # $B%F%9%H%f!<%6!<$,%m%0%$%sCf$N>l9g$K(Btrue$B$rJV$9(B
  def is_logged_in?
    !session[:user_id].nil?
  end
end

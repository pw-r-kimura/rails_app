require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Rintaro Kimura",email: "r-kimura@p-wolrd.co.jp")
  end

  test "should be vaild" do 
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do 
    @user.email = " "
    assert_not @user.valid?
  end
end

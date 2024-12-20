require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "User", 
                    email:"user@mail.com",
                    password: "userpass1", 
                    password_confirmation: "userpass1")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name shoud be present" do
    @user.name = " "
    assert_not@user.valid?
  end
  test "email adddress should be unique" do
    duplicate_user = @user.dup 
    @user.save 
    assert_not duplicate_user.valid?
  end
  test "email address should be saved as lowercase" do
    mixed_case_email = "User@EmaIl.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

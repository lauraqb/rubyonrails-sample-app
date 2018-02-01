# CHAPTER 7 & 8 - The main purpose of our test is to verify that clicking the signup button results in not creating a new user when the submitted information is invalid.
# The way to do this is to check the count of users, and under the hood our tests will use the count method available on every Active Record class.
# In order to test the form submission, we need to issue a POST request to the users_path.
# We’ve also included a call to assert_template to check that a failed submission re-renders the new action.

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end

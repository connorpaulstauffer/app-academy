require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end

  test "non-activated profile requests are redirected" do
    get signup_path
    post users_path, user: { name:  "Non Activate",
                             email: "non@activated.com",
                             password:              "password",
                             password_confirmation: "password" }
    non_activated_user = assigns(:user)
    activated_user = users(:archer)
    get user_path activated_user
    assert_template "users/show"
    get user_path non_activated_user
    follow_redirect!
    assert_template "static_pages/home"
  end


end

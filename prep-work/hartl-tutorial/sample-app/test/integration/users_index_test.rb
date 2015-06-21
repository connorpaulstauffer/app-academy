require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete',
                                                    method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index only shows activated users" do
    last_user = User.last
    get signup_path
    post users_path, user: { name:  "Non Activated",
                             email: "non@activated.com",
                             password:              "password",
                             password_confirmation: "password" }
    non_activated_user = assigns(:user)
    log_in_as @non_admin
    get users_path, :page => ((User.count / 30) + 1)
    assert_select 'a[href=?]', user_path(non_activated_user), count: 0
    assert_select 'a[href=?]', user_path(last_user), count: 1
  end

end

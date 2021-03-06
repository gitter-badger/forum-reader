require 'test_helper'

class ConfirmJabberTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @user.unconfirm_jabber
    assert_not @user.reload.jabber_confirmed?
  end

  test 'success' do
    get confirm_jabber_path(token: @user.jabber_confirmation_token)
    assert_redirected_to info_path

    assert_not_nil @user.reload.jabber_confirmation_at
    assert_not_empty flash.notice
  end

  test 'fail if left token' do
    get confirm_jabber_path(token: 'left-token')
    assert_redirected_to info_path

    assert_nil @user.reload.jabber_confirmation_at
    assert_not_empty flash.alert
  end

  test 'run #auto_sign_in after success' do
    get confirm_jabber_path(token: @user.jabber_confirmation_token)

    assert @controller.send(:signed_in?)
    assert_not_empty flash.notice
  end

  test 'repeat_jabber_confirmation' do
    sign_in(@user.account)
    assert_enqueued_jobs 1 do
      get repeat_jabber_confirmation_path
      assert_redirected_to info_path
    end
  end
end

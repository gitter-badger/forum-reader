# coding: utf-8
require 'test_helper'

class ConfirmEmailTest < ActionController::TestCase
  tests AccountsController

  setup do
    @account = accounts(:john)
    @account.unconfirm_email
    assert_not accounts(:john).email_confirmed?
  end

  test 'success' do
    get :confirm_email, token: @account.email_confirmation_token

    assert_response :redirect
    assert_redirected_to info_path

    assert_not_nil @account.reload.email_confirmation_at
    assert_not_empty flash.notice
  end

  test 'fail if left token' do
    get :confirm_email, token: 'left-token'

    assert_response :redirect
    assert_redirected_to info_path

    assert_nil @account.reload.email_confirmation_at
    assert_not_empty flash.alert
  end

  test 'при success также выполняется auto_sign_in' do
    get :confirm_email, token: @account.email_confirmation_token

    assert @controller.send(:signed_in?)
    assert_not_empty flash.notice
  end
end

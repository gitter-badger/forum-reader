# coding: utf-8
# Подтвердить Email.
#
# Морда для EmailConfirmation.
#
# Консерва AccountsController.
#
module ConfirmEmail
  extend ActiveSupport::Concern

  included do
    skip_before_action :require_sign_in, only: :confirm_email
  end

  ##
  # GET /accounts/confirm_email/:token
  #
  # Выполняется при переходе пипла по ссылке в письме
  # AccountsMailer#email_confirmation.
  #

  def confirm_email
    account = Account.find_by(email_confirmation_token: params[:token])

    if account && confirm(account)
      auto_signin(account)
      flash.notice = t 'success'
    else
      flash.alert = t 'fail'
    end

    redirect_to info_path
  end

  private

  def confirm(account)
    account.confirm_email! unless account.email_confirmed?
    account.email_confirmed?
  end

  def auto_signin(account)
    sign_out
    auto_sign_in(account.email) if account.email_confirmed?
  end
end
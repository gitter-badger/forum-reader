am = ActionMailer::Base
am.deliver_later_queue_name = 'default' # TODO: check

am.default_options = { from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>" }
am.default_url_options = { host: 'localhost', port: 3000 }

if Rails.env.production?
  am.default_url_options = { host: "http://#{APP::HOST}" }
  am.smtp_settings = {
    port: 2525,
    openssl_verify_mode: 'none'
  }
end

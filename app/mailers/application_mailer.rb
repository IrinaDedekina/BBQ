class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(Rails.env.to_sym, :MAILJET_SENDER)
  layout 'mailer'
end

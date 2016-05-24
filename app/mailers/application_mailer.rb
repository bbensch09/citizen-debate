class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@citizendebate.org',
    cc: 'notifications@citizendebate.org'
  layout 'mailer'
end

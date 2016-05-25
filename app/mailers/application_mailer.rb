class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@citizendebate.org',
    cc: 'citizen.debate.16@gmail.com'
  layout 'mailer'
end

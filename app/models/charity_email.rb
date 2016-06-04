class CharityEmail < ActiveRecord::Base
  after_create :send_admin_notification


  def send_admin_notification
      @charity_email = CharityEmail.last
      UserMailer.charity_user_signed_up(@charity_email).deliver_now
      puts "an admin notification has been sent."
  end
end

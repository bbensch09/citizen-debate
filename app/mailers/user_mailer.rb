class UserMailer < ApplicationMailer
  def thank_you_for_snippet(topic,user)
    @topic = topic
    @user = user
    mail(to: @topic.creator.email, subject: "We appreciate your interest!")
  end

  def challenge_existing_user(debate)
    @debate = debate
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger.email, cc: @debate.creator.email, bcc: "citizen.debate.16+notify@gmail.com", subject:"You've been challenged to a Citizen Debate!")
  end

  def challenge_new_user(debate)
    @debate = debate
    # @challenger_temp_password = temp_password
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger_email, cc: @debate.creator.email, bcc: "citizen.debate.16+notify@gmail.com", subject:"You've invited to join Citizen Debate!")
  end

  def new_user_signed_up(user)
    @user = user
    mail(to: "bbensch@gmail.com", subject: "A new user has registered for Citizen Debate!")
  end

end

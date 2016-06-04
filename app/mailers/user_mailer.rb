class UserMailer < ApplicationMailer

  def new_user_signed_up(user)
    @user = user
    mail(to: "notifications@citizendebate.org", subject: "#{user.email} has registered for Citizen Debate!")
  end

  def charity_user_signed_up(charity_email)
    @charity_email = charity_email
    mail(to: "notifications@citizendebate.org", subject: "#{charity_email.email} has registered for the charity debate!")
  end

  def new_profile_created(profile)
    @profile = profile
    mail(to: "notifications@citizendebate.org", subject: "#{profile.user.email} has updated their profile.")
  end

  def debate_vote_recorded(email="Unknown user")
    mail(to: "notifications@citizendebate.org", subject: "#{email} has just voted on a debate.")
  end

  def gotv_clickthru(email="Unknown user")
    mail(to: "notifications@citizendebate.org", subject: "#{email} has just clicked through to the voter-registration page.")
  end

  def track_opens(debate,email="Unknown user")
    @debate = debate
    mail(to: "notifications@citizendebate.org", subject: "#{email} just previewed: #{@debate.resolution}")
  end

  def challenge_existing_user(debate)
    @debate = debate
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger.email, bcc: @debate.creator.email, cc: "notifications@citizendebate.org", subject:"You've been challenged to a Citizen Debate!")
  end

  def challenge_new_user(debate)
    @debate = debate
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger_email, bcc: @debate.creator.email, cc: "notifications@citizendebate.org", subject:"You've been invited to join Citizen Debate!")
  end

  def challenge_accepted(debate)
    @debate = debate
    if debate.affirmative_id == debate.creator_id
      @creator_side = "affirmative"
    else
      @creator_side = "negative"
    end
    mail(to: @debate.creator.email, cc: "notifications@citizendebate.org", subject:"Your debate challenge has been accepted!")
  end

  def schedule_confirmed(debate)
    @debate = debate
    mail(to:"notifications@citizendebate.org", bcc: "#{@debate.creator.email}, #{@debate.challenger.email}", subject:"Your debate schedule is now set.")
  end

  def proposed_times_added(debate)
    @debate = debate
    mail(to:"notifications@citizendebate.org", bcc: "#{@debate.creator.email}, #{@debate.challenger.email}", subject:"Your opponent has added times for you to review.")
  end

  def opening_statement_complete(statement)
      @opening_statement = statement
      @debate = @opening_statement.debate
      if @opening_statement.author.id == @opening_statement.debate.creator.id
        @recipient = @opening_statement.author
      end
      if @opening_statement.debate.challenger && @opening_statement.author.id == @opening_statement.debate.challenger.id
        @recipient = @opening_statement.debate.creator
      end
      if @opening_statement.author.email == "citizen.debate.16@gmail.com"
        @recipient = @opening_statement.debate.creator
      end
      if @debate.affirmative_id == @debate.creator_id
        @creator_side = "affirmative"
      else
        @creator_side = "negative"
      end
    mail(to:"notifications@citizendebate.org", subject: "FYI: #{@opening_statement.author.profile.display_name} has entered their opening statement!")
  end

  def debate_has_ended(debate)
      @debate = debate
      mail(to:"notifications@citizendebate.org", bcc: "#{@debate.creator.email}, #{@debate.challenger.email}", subject: "Your debate has now ended. Share the word and await the results!")
  end

  def notify_follower(follower_email, topic, debate)
    @debate = debate
    @topic = topic
    mail(to: follower_email, subject: "Check out the latest debate: #{@topic.title}")
  end

end

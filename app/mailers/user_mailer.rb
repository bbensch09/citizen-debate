class UserMailer < ApplicationMailer
  def thank_you_for_snippet(topic,user)
    @topic = topic
    @user = user
    mail(to: @topic.creator.email, subject: "We appreciate your interest!")
  end

  def new_user_signed_up(user)
    @user = user
    mail(to: "bbensch@gmail.com", subject: "#{user.email} has registered for Citizen Debate!")
  end

  def new_profile_created(profile)
    @profile = profile
    mail(to: "bbensch@gmail.com", subject: "#{profile.user.email} has completed their profile.")
  end

  def debate_vote_recorded(email="Unknown user")
    mail(to: "bbensch@gmail.com", subject: "#{email} has just voted on a debate.")
  end

  def challenge_existing_user(debate)
    @debate = debate
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger.email, bcc: @debate.creator.email, cc: "citizen.debate.16+notify@gmail.com", subject:"You've been challenged to a Citizen Debate!")
  end

  def challenge_new_user(debate)
    @debate = debate
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger_email, bcc: @debate.creator.email, cc: "citizen.debate.16+notify@gmail.com", subject:"You've been invited to join Citizen Debate!")
  end

  def challenge_accepted(debate)
    @debate = debate
    if debate.affirmative_id == debate.creator_id
      @creator_side = "affirmative"
    else
      @creator_side = "negative"
    end
    mail(to: @debate.creator.email, bcc: @debate.challenger.email, cc: "citizen.debate.16+notify@gmail.com", subject:"Your debate challenge has been accepted!")
  end

  def schedule_confirmed(debate)
    @debate = debate
    mail(to:"citizen.debate.16+notify@gmail.com", bcc: "#{@debate.creator.email}, #{@debate.challenger.email}", subject:"Your debate schedule is now set.")
  end

  def proposed_times_added(debate)
    @debate = debate
    mail(to:"citizen.debate.16+notify@gmail.com", bcc: "#{@debate.creator.email}, #{@debate.challenger.email}", subject:"Your opponent has added times for you to review.")
  end

  def opening_statement_complete(statement)
      @opening_statement = statement
      @debate = @opening_statement.debate
      if @opening_statement.author.id == @opening_statement.debate.creator.id
        @recipient = @opening_statement.debate.challenger
      end
      if @opening_statement.author.id == @opening_statement.debate.challenger.id
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
    mail(to: @recipient.email, bcc: @opening_statement.author.email, subject: "#{@opening_statement.author.profile.display_name} has entered their opening statement!")
  end

  def closing_statement_complete(statement)
      @closing_statement = statement
      @debate = @closing_statement.debate
      if @closing_statement.author.id == @closing_statement.debate.creator.id
        @recipient = @closing_statement.debate.challenger
      end
      if @closing_statement.author.id == @closing_statement.debate.challenger.id
        @recipient = @closing_statement.debate.creator
      end
      if @closing_statement.author.email == "citizen.debate.16@gmail.com"
        @recipient = @closing_statement.debate.creator
      end
      if @debate.affirmative_id == @debate.creator_id
        @creator_side = "affirmative"
      else
        @creator_side = "negative"
      end
      mail(to: @recipient.email, bcc: @closing_statement.author.email, subject: "#{@closing_statement.author.profile.display_name} has entered their closing statement!")
  end

  def notify_follower(follower_email, topic, debate)
    @debate = debate
    @topic = topic
    mail(to: follower_email, subject: "Check out the latest debate: #{@topic.title}")
  end

end

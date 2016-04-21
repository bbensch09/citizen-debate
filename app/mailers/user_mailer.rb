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
    if debate.affirmative_id
      @challenger_side = "negative"
    end
    if debate.negative_id
      @challenger_side = "affirmative"
    end
    mail(to: @debate.challenger_email, cc: @debate.creator.email, bcc: "citizen.debate.16+notify@gmail.com", subject:"You've invited to join Citizen Debate!")
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

  def new_user_signed_up(user)
    @user = user
    mail(to: "bbensch@gmail.com", subject: "#{user.email} has registered for Citizen Debate!")
  end

  def opening_statement_complete(statement)
      @opening_statement = statement
      if @opening_statement.author.user.id == @opening_statement.debate.creator.id
        @recipient = @opening_statement.debate.challenger
      end
      if @opening_statement.author.user.id == @opening_statement.debate.challenger.id
        @recipient = @opening_statement.debate.creator
      end
    mail(to: @recipient.email, bcc: @opening_statement.author.user.email, subject: "#{@opening_statement.author.user.email} has entered their opening statement!")
  end

end

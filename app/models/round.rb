class Round < ActiveRecord::Base
  belongs_to :debate
  has_many :messages
  validates :debate_id, :round_number, presence: true

  validate :confirm_both_sides_finished, on: :update

  def confirm_both_sides_finished
    debate = self.debate
    case round_number
    when 1
      errors.add(:status,"Please wait until your opponent has finished their statement.") unless (debate.opening_affirmative && debate.opening_negative)
    when 2
      errors.add(:status,"You may not end cross examination early unless each side has had the chance to ask at least one question.") unless self.messages.count > 2
    when 3
      errors.add(:status,"You're all set! The debate will be closed when your opponent has finished their statement.") unless (debate.closing_affirmative && debate.closing_negative)
    end

  end


  def time_remaining
    round_length = 300 #300 seconds, 5 minutes
    time_elapsed = Time.now - start_time
    time_remaining = (round_length - time_elapsed)
    if (time_remaining < 0 || self.status == "Completed")
      self.status = "Completed"
      self.save
      return "This round is complete."
    elsif time_remaining < 60
      return "There are #{time_remaining.round} seconds left in this round."
    else
      time_remaining_in_minutes = (time_remaining / 60).round
      time_remaining_in_seconds = (time_remaining % 60).round
      return "There are #{time_remaining_in_minutes} minutes and #{time_remaining_in_seconds} seconds left in this round."
    end
  end

def ends_at
  case round_number
  when 1
    self.end_time = self.start_time + 300 #5minutes
  when 2
    self.end_time = self.start_time + 900 #15minutes
  when 3
    self.end_time = self.start_time + 300 #5minutes
  end
  self.save
  return self.end_time
end

def name
  case round_number
  when 1
    return "Round #1 - Affirmative opening"
  when 2
    return "Round #2 - Negative cross-examination"
  when 3
    return "Round #3 - Negative opening"
  when 4
    return "Round #4 - Affirmative cross-examination"
  when 5
    return "Round #5 - Affirmative rebuttal"
  when 6
    return "Round #6 - Negative rebuttal and closing"
  when 7
    return "Round #7 - Affirmative closing"
  end

end

def cross_ex?
  case round_number
  when 1
    return false
  when 2
    return true
  when 3
    return false
  when 4
    return true
  when 5
    return false
  when 6
    return false
  when 7
    return false
  end

end

def eligible_speakers
    case round_number
    when 1
      return [self.debate.affirmative_debater.user.id]
    when 2
      return [self.debate.negative_debater.user.id, self.debate.affirmative_debater.user.id]
    when 3
      return [self.debate.negative_debater.user.id]
    when 4
      return [self.debate.affirmative_debater.user.id, self.debate.negative_debater.user.id]
    when 5
      return [self.debate.affirmative_debater.user.id]
    when 6
      return [self.debate.negative_debater.user.id]
    when 7
      return [self.debate.affirmative_debater.user.id]
    end
end

def next_speaker
  case round_number
  when 1
    return self.debate.negative_debater.user.id
  when 2
    return self.debate.negative_debater.user.id
  when 3
    return self.debate.affirmative_debater.user.id
  when 4
    return self.debate.affirmative_debater.user.id
  when 5
    return self.debate.negative_debater.user.id
  when 6
    return self.debate.affirmative_debater.user.id
  end
end

def eligible_speaker_name
  if eligible_speakers.count == 1
    current_speaker = User.find(eligible_speakers.first).profile.display_name
    return "It is #{current_speaker}'s turn during this round."
  else
    return "Both participants may submit messages during cross-examination."
  end
end

end

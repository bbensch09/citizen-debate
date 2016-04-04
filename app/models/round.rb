class Round < ActiveRecord::Base
  belongs_to :debate
  has_many :messages

  def time_remaining
    return "The debate start time has not yet been confirmed." if start_time.nil?
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

def multiple_messages_per_round?
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

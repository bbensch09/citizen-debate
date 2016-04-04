class Round < ActiveRecord::Base
  belongs_to :debate
  has_many :messages

  def time_remaining
    return "This debate has not yet started." if start_time.nil?
    round_length = 300 #300 seconds, 5 minutes
    time_elapsed = Time.now - start_time
    time_remaining = (round_length - time_elapsed)
    if time_remaining < 0
      self.status = "Completed"
      self.save
      return "This round is complete."
    elsif time_remaining < 60
      return "You have #{time_remaining} seconds left in this round."
    else
      time_remaining_in_minutes = (time_remaining / 60).round
      time_remaining_in_seconds = (time_remaining % 60).round
      return "You have #{time_remaining_in_minutes} minutes and #{time_remaining_in_seconds} seconds left in this round."
    end
  end
end

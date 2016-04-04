class Round < ActiveRecord::Base
  belongs_to :debate
  has_many :messages

  def time_remaining
    round_length = 300 #300 seconds, 5 minutes
    time_elapsed = Time.now - created_at.to_time
    time_remaining = (round_length - time_elapsed)
    if time_remaining < 0
      self.status = "Completed"
      self.save
      return "This round is complete."
    elsif time_remaining < 60
      return "You have #{time_remaining} seconds left in this round."
    else
      time_remaining_in_minutes = (time_remaining / 60).round
      return "You have #{time_remaining_in_minutes} minutes left in this round."
    end
  end
end

class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :topic_votes

  def rank
  end

  def time_since_written
    time_elapsed = ((Time.now - created_at.to_time) / (60*60*24)).round
      if time_elapsed < 1
        return "today."
      else
        return "#{time_elapsed} days ago."
      end
  end
end

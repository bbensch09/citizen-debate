class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :votes, :class_name => "TopicVote"

  def score
    collected_votes = self.votes
    score = 0
    collected_votes.each do |vote|
      score += vote.value
    end
    return score
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

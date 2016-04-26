class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :votes, :class_name => "TopicVote"
  has_many :debates

  def score
    collected_votes = self.votes
    score = 0
    collected_votes.each do |vote|
      score += vote.value
    end
    return score
  end

  def followers
      topic_votes_with_followers = TopicVote.where("topic_id=? AND following=true",self.id)
      follower_ids = []
      topic_votes_with_followers.each do |topic_vote|
        follower_ids << topic_vote.voter_id
      end
      follower_emails =[]
      follower_ids.each do |id|
        follower_emails << User.find(id).email
      end
      return follower_emails
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

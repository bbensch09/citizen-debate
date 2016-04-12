class User < ActiveRecord::Base
  has_many :snippets
  has_many :topics
  has_many :topic_votes, class_name: "TopicVote", foreign_key: "voter_id"
  has_one :profile
  has_one :judge
  has_one :debater
  has_many :debate_votes
  has_many :civility_votes
  # Include default devise modules. Others available are:
  # Need to activate Omniauthabl to use FB still :omniauthable
  # Also need to reactivate :confirmable to resume email confirmations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable#, :confirmable

  # HACKY SHIT
  has_many :comments, dependent: :delete_all

  def self.to_csv
    attributes = %w{id email created_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr)}
      end
    end
  end

  def time_since_created
    time_elapsed = ((Time.now - created_at.to_time) / (60*60*24)).round
      if time_elapsed < 1
        return "Today"
      else
        return "#{time_elapsed} days ago"
      end
  end

  def rank
    if self.profile.nil?
      return "N/A (You must first complete your profile to join the wait list)"
    else
      return self.profile.rank
    end
  end

  def before_votes
    all_before_votes = DebateVote.where("user_id = ?",self.id)
    before_debate_ids = []
    all_before_votes.each do |vote|
      before_debate_ids << vote.debate_id
    end
    return before_debate_ids
  end

  def eligible_after_votes
    eligible_after_votes = DebateVote.where("user_id = ? AND vote_after is null",self.id)
    eligible_debate_ids = []
    eligible_after_votes.each do |vote|
      eligible_debate_ids << vote.debate_id
    end
    return eligible_debate_ids
  end

  def eligible_civility_votes
    # identify all completed debates that are accepting votes
    all_completed_debates = Debate.select(:id).where("status='Completed'")
    all_debate_ids = []
    all_completed_debates.each do |debate|
      all_debate_ids << debate.id
    end
    # identify previous debates the user has voted on
    previous_votes = CivilityVote.where("voter_id = ?",self.id)
    previous_vote_debate_ids = []
    previous_votes.each do |vote|
      previous_vote_debate_ids << vote.debate_id
    end
    # identify debates in which the user was a participant
    particpant_debate_ids = []
    if self.debater
      particpant_debates = Debate.where("affirmative_id = ? OR negative_id = ?",self.debater.id,self.debater.id)
      particpant_debates.each do |debate|
        particpant_debate_ids << debate.id
      end
    end
    #calculate civility vote eligibility by subtracting #2 and #3 from #1
    eligible_to_vote_debates = all_debate_ids - previous_vote_debate_ids - particpant_debate_ids
    return eligible_to_vote_debates
  end

end

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

end

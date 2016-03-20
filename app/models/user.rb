class User < ActiveRecord::Base
  has_many :snippets
  has_many :topics
  has_many :votes
  has_one :profile
  # Include default devise modules. Others available are:
  # Need to activate Omniauthabl to use FB still :omniauthable
  # Also need to reactivate :confirmable to resume email confirmations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable#, :confirmable

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

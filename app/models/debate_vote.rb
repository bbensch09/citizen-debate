class DebateVote < ActiveRecord::Base
belongs_to :debate
belongs_to :user
validates :debate_id, :user_id, presence: true
validates :user_id, uniqueness: {scope: :debate_id}

end

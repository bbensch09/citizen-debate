class DebateVote < ActiveRecord::Base
  belongs_to :debate
  belongs_to :user
end

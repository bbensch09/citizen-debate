class TopicVote < ActiveRecord::Base
  belongs_to :topic
  belongs_to :voter, :class_name => "User"
end

class CivilityVote < ActiveRecord::Base
  belongs_to :debate
  belongs_to :debater
  belongs_to :voter, class_name: "User", foreign_key: "voter_id"
end

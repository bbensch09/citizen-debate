class Verdict < ActiveRecord::Base
  belongs_to :debate
  # has_one :winner, class_name: "Debater", foreign_key: "winner_id" #HACKY SHIT --> this may not be necessary
end

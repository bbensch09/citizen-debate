class Round < ActiveRecord::Base
  belongs_to :debate
  has_many :messages
end

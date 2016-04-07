class ClosingStatement < ActiveRecord::Base
  belongs_to :round
  belongs_to :debate
  belongs_to :author, class_name: "Debater", foreign_key: "author_id"

end

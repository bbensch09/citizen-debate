class Verdict < ActiveRecord::Base
  belongs_to :debate

  def winner
    Debater.find(self.winner_id)
  end

end

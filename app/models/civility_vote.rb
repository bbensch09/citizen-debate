class CivilityVote < ActiveRecord::Base
  belongs_to :debate
  belongs_to :debater
  belongs_to :voter, class_name: "User", foreign_key: "voter_id"
  after_create :send_admin_notification

  def send_admin_notification
    @civility_vote = CivilityVote.last
    if @civility_vote.voter_id
      UserMailer.debate_vote_recorded(@civility_vote.voter.email).deliver_now
    else
      UserMailer.debate_vote_recorded.deliver_now
    end
    puts "admin has been notified"
  end

end

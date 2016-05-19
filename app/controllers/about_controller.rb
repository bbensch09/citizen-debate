class AboutController < ApplicationController
  def reputation
    render 'reputation'
  end

  def debate_format
    render 'debate_format'
  end

  def BingSiteAuth
  end

  def register_to_vote
    if current_user && current_user.email
      UserMailer.gotv_clickthru(current_user.email).deliver_now
    else
      UserMailer.gotv_clickthru.deliver_now
    end
  end

end

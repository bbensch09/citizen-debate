class WelcomeController < ApplicationController

  def index
      @debate = Debate.where("status = 'Completed' ").last
      @pending_debates = Debate.where("status = 'Pending'")
  end

  def early_adopter_program
  end

  def charity_debate
        @charity_email = CharityEmail.new
        render :layout => 'charity'
  end
end

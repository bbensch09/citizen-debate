class WelcomeController < ApplicationController
  def index
      @debate = Debate.where("status = 'Completed' ").last
  end

  def early_adopter_program
  end
end

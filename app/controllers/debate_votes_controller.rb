class DebateVotesController < ApplicationController
  before_action :set_debate_vote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create]


  # GET /debate_votes
  # GET /debate_votes.json
  def index
    @debate_votes = DebateVote.all
  end

  # GET /debate_votes/1

  # GET /debate_votes/1.json
  def show
  end

  # GET /debate_votes/new
  def new
    @debate_vote = DebateVote.new
  end

  # GET /debate_votes/1/edit
  def edit
  end

  # POST /debate_votes
  # POST /debate_votes.json
#HACKY SHIT: session storage of before votes could use some cleanup
  def create
    @debate_vote = DebateVote.new(debate_vote_params)
    if @debate_vote.vote_after
        if current_user.nil?
          puts "user not yet signed in"
          # authenticate_user!
          session[:vote_after] = @debate_vote.vote_after
        end
        if session[:vote_before]
        puts "checking to see if there is a session variable that exists..."
        puts  "the session variable for vote_before is #{session[:vote_before]}"
        @debate_vote.vote_before = session[:vote_before]
        puts "successfully retrieved temp_vote value post-authentication"
        end
        # @debate_vote.user_id = current_user.id

        respond_to do |format|
          if @debate_vote.save
            #after saving, set vote_after to already_voted.
            # session[:vote_before] = nil
            session[:vote_after] = 'already_voted'
            format.html { redirect_to @debate_vote.debate, notice: "Thanks! Your debate vote has successfully been recorded. Your initial vote was '#{@debate_vote.vote_before},' and your final vote was '#{@debate_vote.vote_after}'." }
            format.json { render :show, status: :created, location: @debate_vote }
          else
            format.html { redirect_to @debate_vote.debate, notice: "There was a problem recording your vote, please try again. Error: #{@debate_vote.errors.full_messages.first}" }
            format.json { render json: @debate_vote.errors, status: :unprocessable_entity }
          end
        end

      else
        session[:vote_before] = @debate_vote.vote_before
        puts "a temporary vote_before has been saved. the user has voted #{session[:vote_before]}."
        redirect_to @debate_vote.debate, notice: 'Thanks! Your initial vote has been temporarily recorded.'
    end
  end

  # PATCH/PUT /debate_votes/1
  # PATCH/PUT /debate_votes/1.json
  def update
    respond_to do |format|
      if @debate_vote.update(debate_vote_params)
        format.html { redirect_to @debate_vote.debate, notice: 'Thanks! Your final vote has been recorded.'}
        format.json { render :show, status: :ok, location: @debate_vote }
      else
        format.html { redirect_to @debate_vote.debate, notice: "There was a problem recording your vote, please try again. Error: #{@debate_vote.errors.full_messages.first}" }
        format.json { render json: @debate_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debate_votes/1
  # DELETE /debate_votes/1.json
  def destroy
    @debate_vote.destroy
    respond_to do |format|
      format.html { redirect_to debate_votes_url, notice: 'Debate vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debate_vote
      @debate_vote = DebateVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debate_vote_params
      params.require(:debate_vote).permit(:user_id, :vote_before, :vote_after, :debate_id)
    end
end

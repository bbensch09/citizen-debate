class DebateVotesController < ApplicationController
  before_action :set_debate_vote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


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
  def create
    @debate_vote = DebateVote.new(debate_vote_params)
    @debate_vote.user_id = current_user.id

    respond_to do |format|
      if @debate_vote.save
        format.html { redirect_to @debate_vote.debate, notice: 'Thanks! Your vote has been recorded.' }
        format.json { render :show, status: :created, location: @debate_vote }
      else
        format.html { redirect_to @debate_vote.debate, notice: "There was a problem recording your vote, please try again. Error: #{@debate_vote.errors.full_messages.first}" }
        format.json { render json: @debate_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debate_votes/1
  # PATCH/PUT /debate_votes/1.json
  def update
    respond_to do |format|
      if @debate_vote.update(debate_vote_params)
        format.html { redirect_to @debate_vote.debate, notice: 'Thanks! Your vote has been recorded.' }
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

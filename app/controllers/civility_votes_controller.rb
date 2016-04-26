class CivilityVotesController < ApplicationController
  before_action :set_civility_vote, only: [:show, :edit, :update, :destroy]
  after_action :update_leaderboard
  # before_action :authenticate_user!

  def update_leaderboard
    profiles = Profile.all
    profiles.each do |profile|
      profile.update_points
    end
  end
  # GET /civility_votes
  # GET /civility_votes.json
  def index
    @civility_votes = CivilityVote.all
  end

  # GET /civility_votes/1
  # GET /civility_votes/1.json
  def show
  end

  # GET /civility_votes/new
  def new
    @civility_vote = CivilityVote.new
  end

  # GET /civility_votes/1/edit
  def edit
  end

  # POST /civility_votes
  # POST /civility_votes.json
  def create
    @civility_vote = CivilityVote.new(civility_vote_params)

    respond_to do |format|
      if @civility_vote.save
        session[:civility_vote] = @civility_vote
        format.html { redirect_to @civility_vote.debate, notice: 'Your votes have been recorded. Thank you for rating our debaters!' }
        format.json { render :show, status: :created, location: @civility_vote }
      else
        format.html { render :new }
        format.json { render json: @civility_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /civility_votes/1
  # PATCH/PUT /civility_votes/1.json
  def update
    respond_to do |format|
      if @civility_vote.update(civility_vote_params)
        format.html { redirect_to @civility_vote, notice: 'Civility vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @civility_vote }
      else
        format.html { render :edit }
        format.json { render json: @civility_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /civility_votes/1
  # DELETE /civility_votes/1.json
  def destroy
    @civility_vote.destroy
    respond_to do |format|
      format.html { redirect_to civility_votes_url, notice: 'Civility vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_civility_vote
      @civility_vote = CivilityVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def civility_vote_params
      params.require(:civility_vote).permit(:voter_id, :debate_id, :affirmative_id, :negative_id, :affirmative_rating, :negative_rating)
    end
end

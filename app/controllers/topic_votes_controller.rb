class TopicVotesController < ApplicationController
  before_action :set_topic_vote, only: [:show, :edit, :update, :destroy]

  def upvote
    # HACKY SHIT --> confirm scope on these instance variables
    @topic = Topic.find(params[:id])
    @topic_vote = TopicVote.new
    @topic_vote.value = 1
    @topic_vote.voter_id = current_user.id
    @topic_vote.topic_id = @topic.id
    @topic_vote.save
    redirect_to(topics_path)
  end

  def downvote
    # HACKY SHIT --> confirm scope on these instance variables
    @topic = Topic.find(params[:id])
    @topic_vote = TopicVote.new
    @topic_vote.value = -1
    @topic_vote.voter_id = current_user.id
    @topic_vote.topic_id = @topic.id
    @topic_vote.save
    redirect_to(topics_path)
  end

  # GET /topic_votes
  # GET /topic_votes.json
  def index
    @topic_votes = TopicVote.all
  end

  # GET /topic_votes/1
  # GET /topic_votes/1.json
  def show
  end

  # GET /topic_votes/new
  def new
    @topic_vote = TopicVote.new
  end

  # GET /topic_votes/1/edit
  def edit
  end

  # POST /topic_votes
  # POST /topic_votes.json
  def create
    @topic_vote = TopicVote.new(topic_vote_params)
    respond_to do |format|
      if @topic_vote.save
        format.html { redirect_to @topic_vote, notice: 'Topic vote was successfully created.' }
        format.json { render :show, status: :created, location: @topic_vote }
      else
        format.html { render :new }
        format.json { render json: @topic_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topic_votes/1
  # PATCH/PUT /topic_votes/1.json
  def update
    respond_to do |format|
      if @topic_vote.update(topic_vote_params)
        format.html { redirect_to @topic_vote, notice: 'Topic vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic_vote }
      else
        format.html { render :edit }
        format.json { render json: @topic_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_votes/1
  # DELETE /topic_votes/1.json
  def destroy
    @topic_vote.destroy
    respond_to do |format|
      format.html { redirect_to topic_votes_url, notice: 'Topic vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic_vote
      @topic_vote = TopicVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_vote_params
      params.require(:topic_vote).permit(:value,:topic_id,:voter_id)
    end
end

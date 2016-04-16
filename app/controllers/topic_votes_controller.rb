class TopicVotesController < ApplicationController
  before_action :set_topic_vote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def upvote
    topic = Topic.find(params[:id])
    topic_vote = TopicVote.new
    topic_vote.value = 1
    topic_vote.voter_id = current_user.id
    topic_vote.topic_id = topic.id
    if TopicVote.where(topic_id:topic.id,voter_id:current_user.id).empty?
      topic_vote.save
      redirect_to(topics_path, notice: 'Your up vote was successfully recorded.' )
    elsif TopicVote.where(topic_id:topic.id,voter_id:current_user.id,value:1).count >= 1
      redirect_to(topics_path, notice: 'You may only vote once, you have already voted for on this topic.')
      # topic_vote.save
      # redirect_to(topics_path, notice: 'Your previous down vote was changed to an up vote.')
    else
    end
  end

  # def downvote
  #   topic = Topic.find(params[:id])
  #   topic_vote = TopicVote.new
  #   topic_vote.value = -1
  #   topic_vote.voter_id = current_user.id
  #   topic_vote.topic_id = topic.id
  #   if TopicVote.where(topic_id:topic.id,voter_id:current_user.id).empty?
  #     topic_vote.save
  #     redirect_to(topics_path, notice: 'Your down vote was successfully recorded.' )
  #   elsif TopicVote.where(topic_id:topic.id,voter_id:current_user.id).last.value == 1
  #     topic_vote.save
  #     redirect_to(topics_path, notice: 'Your previous up vote was changed to a down vote.')
  #   else
  #     redirect_to(topics_path, notice: 'You may only vote once, you have already voted down on this topic.')
  #   end
  # end

  def follow
    topic = Topic.find(params[:id])
    if TopicVote.where(topic_id:topic.id,voter_id:current_user.id).empty?
      redirect_to(topics_path, notice: 'You can only follow a topic once you have liked it.')
    else
    topic_vote = TopicVote.where(topic_id:topic.id,voter_id:current_user.id).first
    topic_vote.following = true
    topic_vote.save
    redirect_to(topics_path, notice: 'You are following this topic.' )
    end
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
